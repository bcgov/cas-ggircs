/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
import { FragmentRefs } from "relay-runtime";
export type pagesQueryVariables = {};
export type pagesQueryResponse = {
    readonly query: {
        readonly session: {
            readonly " $fragmentRefs": FragmentRefs<"DefaultLayout_session">;
        } | null;
    };
};
export type pagesQuery = {
    readonly response: pagesQueryResponse;
    readonly variables: pagesQueryVariables;
};



/*
query pagesQuery {
  query {
    session {
      ...DefaultLayout_session
    }
    id
  }
}

fragment DefaultLayout_session on JwtToken {
  ggircsUserBySub {
    __typename
    id
  }
}
*/

const node: ConcreteRequest = (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "pagesQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "Query",
        "kind": "LinkedField",
        "name": "query",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "JwtToken",
            "kind": "LinkedField",
            "name": "session",
            "plural": false,
            "selections": [
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "DefaultLayout_session"
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [],
    "kind": "Operation",
    "name": "pagesQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "Query",
        "kind": "LinkedField",
        "name": "query",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "JwtToken",
            "kind": "LinkedField",
            "name": "session",
            "plural": false,
            "selections": [
              {
                "alias": null,
                "args": null,
                "concreteType": "GgircsUser",
                "kind": "LinkedField",
                "name": "ggircsUserBySub",
                "plural": false,
                "selections": [
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "__typename",
                    "storageKey": null
                  },
                  (v0/*: any*/)
                ],
                "storageKey": null
              }
            ],
            "storageKey": null
          },
          (v0/*: any*/)
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "53611b013670c2d427c5ee74f15fc7c2",
    "id": null,
    "metadata": {},
    "name": "pagesQuery",
    "operationKind": "query",
    "text": "query pagesQuery {\n  query {\n    session {\n      ...DefaultLayout_session\n    }\n    id\n  }\n}\n\nfragment DefaultLayout_session on JwtToken {\n  ggircsUserBySub {\n    __typename\n    id\n  }\n}\n"
  }
};
})();
(node as any).hash = 'a557d44ebae125a5e1d0bad1868b656b';
export default node;
