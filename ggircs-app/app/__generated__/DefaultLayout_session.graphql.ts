/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ReaderFragment } from "relay-runtime";
import { FragmentRefs } from "relay-runtime";
export type DefaultLayout_session = {
    readonly ggircsUserBySub: {
        readonly __typename: string;
    } | null;
    readonly " $refType": "DefaultLayout_session";
};
export type DefaultLayout_session$data = DefaultLayout_session;
export type DefaultLayout_session$key = {
    readonly " $data"?: DefaultLayout_session$data;
    readonly " $fragmentRefs": FragmentRefs<"DefaultLayout_session">;
};



const node: ReaderFragment = {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "DefaultLayout_session",
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
        }
      ],
      "storageKey": null
    }
  ],
  "type": "JwtToken",
  "abstractKey": null
};
(node as any).hash = '61b6af6438dc2c1ca4e25688fb7ab0a0';
export default node;
