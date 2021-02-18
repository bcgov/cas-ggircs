import { NextComponentType, NextPageContext } from "next";
import { GraphQLTaggedNode, MutationConfig } from "relay-runtime";
import { NextRouter } from "next/router";
import { ComponentClass } from "react";
import { CacheConfig } from "react-relay-network-modern/node8";

interface PageInitialProps {
  pageProps: {
    router: NextRouter;
    variables: Record<string, any>;
  };
}

interface PageComponentProps {
  query?: any;
  router?: NextRouter;
}

export type PageComponent = NextComponentType<
  NextPageContext,
  PageInitialProps,
  PageComponentProps
> &
  ComponentClass<PageComponentProps> & {
    static query: GraphQLTaggedNode;
    static isAccessProtected: boolean;
    static allowedGroups: string[];
  };

export interface CacheConfigWithDebounce extends CacheConfig {
  debounceKey?: string;
}

export interface MutationConfigWithDebounce<T> extends MutationConfig<T> {
  cacheConfig?: CacheConfigWithDebounce;
}

export interface EcccFile {
  name: string;
  size: number;
  created_at: string;
}
