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
    query: GraphQLTaggedNode;
    isAccessProtected: boolean;
    allowedGroups: string[];
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

export interface RelayReportObject {
  node: {
    swrsReportId: number;
    latestSwrsReport: {
      submissionDate: string;
      ecccXmlFileByEcccXmlFileId: {
        xmlFileName: string;
        xmlFile: string;
        ecccZipFileByZipFileId: {
          zipFileName: string;
        };
      };
    };
  };
}

export interface SwrsReportData {
  submissionDate: string;
  ecccXmlFileByEcccXmlFileId: {
    xmlFileName: string;
    xmlFile: string;
    ecccZipFileByZipFileId: {
      zipFileName: string;
    };
  };
}
