/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
export type PageRedirectHandlerQueryVariables = {};
export type PageRedirectHandlerQueryResponse = {
    readonly session: {
        readonly userGroups: ReadonlyArray<string | null> | null;
        readonly ggircsUserBySub: {
            readonly __typename: string;
        } | null;
    } | null;
};
export type PageRedirectHandlerQuery = {
    readonly response: PageRedirectHandlerQueryResponse;
    readonly variables: PageRedirectHandlerQueryVariables;
};



/*
query PageRedirectHandlerQuery {
  session {
    userGroups
    ggircsUserBySub {
      __typename
      id
    }
  }
}
*/

const node: ConcreteRequest = (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "userGroups",
  "storageKey": null
},
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "PageRedirectHandlerQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "JwtToken",
        "kind": "LinkedField",
        "name": "session",
        "plural": false,
        "selections": [
          (v0/*: any*/),
          {
            "alias": null,
            "args": null,
            "concreteType": "GgircsUser",
            "kind": "LinkedField",
            "name": "ggircsUserBySub",
            "plural": false,
            "selections": [
              (v1/*: any*/)
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
    "name": "PageRedirectHandlerQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "JwtToken",
        "kind": "LinkedField",
        "name": "session",
        "plural": false,
        "selections": [
          (v0/*: any*/),
          {
            "alias": null,
            "args": null,
            "concreteType": "GgircsUser",
            "kind": "LinkedField",
            "name": "ggircsUserBySub",
            "plural": false,
            "selections": [
              (v1/*: any*/),
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "id",
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "ce38adc2f61c2761e2a4f2cb7ea7d881",
    "id": null,
    "metadata": {},
    "name": "PageRedirectHandlerQuery",
    "operationKind": "query",
    "text": "query PageRedirectHandlerQuery {\n  session {\n    userGroups\n    ggircsUserBySub {\n      __typename\n      id\n    }\n  }\n}\n"
  }
};
})();
(node as any).hash = '377745912020418ba289328466b648b9';
export default node;
