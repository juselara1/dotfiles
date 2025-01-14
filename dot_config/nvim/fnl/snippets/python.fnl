(local F (require :functions))

(fn var-snippet [s c i fmta]
  "Defines the snippets to create variables"
  (s "@var" (c 1 [(fmta "<name> = <value>"
                        {:name (i 1 "name") :value (i 2 "value")})
                  (fmta "<name> : <type> = <value>"
                        {:name (i 1 "name")
                         :type (i 2 "type")
                         :value (i 3 "value")})])))

(fn import-snippet [s c i fmta]
  "Defines the snippet to import packages"
  (s "@import" (c 1 [(fmta "import <module>" {:module (i 1 "module")})
                     (fmta "import <module> as <alias>"
                           {:module (i 1 "module") :alias (i 2 "alias")})
                     (fmta "from <module> import <submodule>"
                           {:module (i 1 "module")
                            :submodule (i 2 "submodule")})
                     (fmta "from <module> import <submodule> as <alias>"
                           {:module (i 1 "module")
                            :submodule (i 2 "submodule")
                            :alias (i 3 "alias")})])))

(fn fn-snippet [s c i fmta]
  "Defines a snippet for functions"
  (s "@fn" (c 1 [(fmta "def <name>(<params>) ->> <rtype>:
    <body>"
                       {:name (i 1 "name")
                        :params (i 2 "")
                        :rtype (i 3 "None")
                        :body (i 4 "...")})
                 (fmta "lambda <params> : <body>"
                       {:params (i 1 "") :body (i 2 "...")})])))

(fn for-snippet [s c i fmta]
  "Defines the snippet for a for loop"
  (s "@for" (c 1 [(fmta "for <element> in <iterable>:
    <body>"
                        {:element (i 1 "i")
                         :iterable (i 2 "iterable")
                         :body (i 3 "...")})
                  (fmta "for <index>, <value> in enumerate(<iterable>):
    <body>"
                        {:index (i 1 "i")
                         :value (i 2 "value")
                         :iterable (i 3 "iterable")
                         :body (i 4 "...")})])))

(fn class-snippet [s c i fmta]
  "Defines the snippet for classes"
  (s "@class" (c 1 [(fmta "class <name>(<super>):
    <body>"
                          {:name (i 1 "Class")
                           :super (i 2 "")
                           :body (i 3 "...")})
                    (fmta "class <name>(ABC):
    <body>" {:name (i 1 "Class") :body (i 2 "...")})])))

(fn method-snippet [s c i fmta]
  "Defines the snippet for methods"
  (s "@method" (c 1 [(fmta "def <name>(self, <params>) ->> <rtype>:
    <body>"
                           {:name (i 1 "name")
                            :params (i 2 "")
                            :rtype (i 3 "None")
                            :body (i 4 "...")})
                     (fmta "@abstractmethod
def <name>(self, <params>) ->> <rtype>:
    <body>"
                           {:name (i 1 "name")
                            :params (i 2 "")
                            :rtype (i 3 "None")
                            :body (i 4 "...")})])))

(fn dataclass-snippet [s c i fmta]
  "Defines the snippet for dataclasses"
  (s "@dataclass" (c 1
                     [(fmta "class <name>(BaseModel):
    <body>" {:name (i 1 "Class") :body (i 2 "...")})
                      (fmta "@dataclass
class <name>():
    <body>" {:name (i 1 "Class") :body (i 2 "...")})])))

(fn dataclass-member-snippet [s c i fmta]
  "Defines the snippet for dataclass fields"
  (s "@dataclass-member"
     (c 1 [(fmta "<name> : <type>" {:name (i 1 "name") :type (i 2 "None")})
           (fmta "<name> : <type> = <value>"
                 {:name (i 1 "name") :type (i 2 "None") :value (i 3 "value")})
           (fmta "<name> : <type> = Field(description=\"<description>\")"
                 {:name (i 1 "name")
                  :type (i 2 "None")
                  :description (i 3 "description")})])))

(fn enum-snippet [s c i fmta]
  "Defines the snippet for enums"
  (s "@enum" (c 1 [(fmta "class <name>(Enum):
    <body>" {:name (i 1 "Class") :body (i 2 "...")})
                   (fmta "class <name>(StrEnum):
    <body>" {:name (i 1 "Class") :body (i 2 "...")})])))

(fn enum-member-snippet [s c i fmta]
  "Defines the snippet for enum members"
  (s "@enum-member" (fmta "<name> = auto()" {:name (i 1 "NAME")})))

(local fn-types [:function_definition :method_definition :func_literal])
(local class-types [:class_definition])
(fn validate-ts-docstring-node [node]
  "Validates if a treesitter node is suitable for docstring"
  (let [node-type (node.type node)]
    (or (F.in fn-types node-type) (F.in class-types node-type))))

(fn detect-ts-docstring-node [node]
  "Finds the parent node that is more suitable for docstring"
  (if (= node nil) node
      (validate-ts-docstring-node node) node
      (detect-ts-docstring-node (node.parent node))))

(fn get-treesitter-captures [node query]
  "Extracts all captures from a treesitter query"
  (var elements {})
  (each [_ capture (query.iter_captures query node 0)]
    (table.insert elements (vim.treesitter.get_node_text capture 0)))
  elements)

(fn get-fn-params [node]
  "Extracts function parameters using treesitter queries"
  (let [param-names-q (vim.treesitter.query.get :python :get-fn-pnames)
        param-types-q (vim.treesitter.query.get :python :get-fn-ptypes)]
    (F.zip (get-treesitter-captures node param-names-q)
           (get-treesitter-captures node param-types-q) :param :type)))

(fn get-fn-rtype [node]
  "Extracts function return type using a treesitter query"
  (. (get-treesitter-captures node
                              (vim.treesitter.query.get :python :get-fn-rtype))
     1))

(fn restructured-text-fn [params rtype i fmta]
  "Generates restructured text docstring for functions"
  (fmta (string.format "\"\"\"
<description>

%s
:returns: <rdoc>
:rtype: %s
\"\"\"" (F.strjoin (icollect [idx param (ipairs params)]
                                            (string.format ":param %s: <description%s>\n:type %s: %s"
                                                           param.param (+ idx 1)
                                                           param.param
                                                           param.type))
                                          "\n")
                       rtype)
        (do
          (var fields
               {:description (i 1 "ReStructuredText")
                :rdoc (i (+ (length params) 2) "description")})
          (each [idx value (ipairs params)]
            (tset fields (.. :description (+ idx 1)) (i (+ idx 1) :description)))
          fields)))

(fn numpydoc-fn [params rtype i fmta]
  "Generates numpydoc docstring for functions"
  (fmta (string.format "\"\"\"
<description>

Parameters
----------
%s

Returns
-------
%s
    <rdoc>
\"\"\"" (F.strjoin (icollect [idx param (ipairs params)]
                                            (string.format "%s : %s\n    <description%s>"
                                                           param.param
                                                           param.type (+ idx 1)))
                                          "\n")
                       rtype)
        (do
          (var fields
               {:description (i 1 "NumpyDoc")
                :rdoc (i (+ (length params) 2) "description")})
          (each [idx value (ipairs params)]
            (tset fields (.. :description (+ idx 1)) (i (+ idx 1) :description)))
          fields)))

(fn fn-docstring [node c i fmta]
  "Generates the snippets for function's docstrings"
  (let [params (get-fn-params node)
        rtype (get-fn-rtype node)]
    (c 1 [(restructured-text-fn params rtype i fmta)
          (numpydoc-fn params rtype i fmta)])))

(fn get-class-params [node]
  "Extracts function parameters using treesitter queries"
  (let [param-names-q (vim.treesitter.query.get :python :get-class-pnames)
        param-types-q (vim.treesitter.query.get :python :get-class-ptypes)]
    (F.zip (get-treesitter-captures node param-names-q)
           (get-treesitter-captures node param-types-q) :param :type)))

(fn restructured-text-class [params i fmta]
  "Generates restructured text docstring for classes"
  (fmta (string.format "\"\"\"
<description>

%s
\"\"\"" (F.strjoin (icollect [idx param (ipairs params)]
                                            (string.format ":param %s: <description%s>\n:type %s: %s"
                                                           param.param (+ idx 1)
                                                           param.param
                                                           param.type))
                                          "\n"))
        (do
          (var fields {:description (i 1 "ReStructuredText")})
          (each [idx value (ipairs params)]
            (tset fields (.. :description (+ idx 1)) (i (+ idx 1) :description)))
          fields)))

(fn class-docstring [node c i fmta]
  "Generates the snippets for classes' docstrings"
  (let [params (get-class-params node)]
    (c 1 [(restructured-text-class params i fmta)])))

(fn handle-docstring [node c i fmta]
  "Generates docstring for functions or classes"
  (if (F.in fn-types (node.type node)) (fn-docstring node c i fmta)
      (class-docstring node c i fmta)))

(fn docstring-snippet [s c i fmta d sn t]
  "Defines the snippet for docstrings."
  (s "@docstring" (d 1 (λ []
                         (let [node (detect-ts-docstring-node (vim.treesitter.get_node))]
                           (case node
                             n (sn nil (handle-docstring n c i fmta))
                             nil (sn nil (t ""))))))))

(fn setup [ls fm]
  "Setup python snippets"
  (let [fmta (. fm :fmta)
        s (. ls :snippet)
        sn (. ls :snippet_node)
        i (. ls :insert_node)
        t (. ls :text_node)
        c (. ls :choice_node)
        f (. ls :function_node)
        d (. ls :dynamic_node)
        nl (λ [] (t ["" ""]))]
    (ls.add_snippets "python"
                     [(var-snippet s c i fmta)
                      (import-snippet s c i fmta)
                      (fn-snippet s c i fmta)
                      (for-snippet s c i fmta)
                      (class-snippet s c i fmta)
                      (method-snippet s c i fmta)
                      (dataclass-snippet s c i fmta)
                      (dataclass-member-snippet s c i fmta)
                      (enum-snippet s c i fmta)
                      (enum-member-snippet s c i fmta)
                      (docstring-snippet s c i fmta d sn t)])))

(let [ls (F.safe-require "luasnip")
      fm (F.safe-require "luasnip.extras.fmt")]
  (if (and (not= ls nil) (not= fm nil))
      (setup ls fm)))
