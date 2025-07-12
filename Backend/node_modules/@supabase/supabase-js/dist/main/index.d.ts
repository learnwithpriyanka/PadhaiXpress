import SupabaseClient from './SupabaseClient';
import type { GenericSchema, SupabaseClientOptions } from './lib/types';
import type { GetGenericDatabaseWithOptions } from '@supabase/postgrest-js';
export * from '@supabase/auth-js';
export type { User as AuthUser, Session as AuthSession } from '@supabase/auth-js';
export { type PostgrestResponse, type PostgrestSingleResponse, type PostgrestMaybeSingleResponse, PostgrestError, } from '@supabase/postgrest-js';
export { FunctionsHttpError, FunctionsFetchError, FunctionsRelayError, FunctionsError, type FunctionInvokeOptions, FunctionRegion, } from '@supabase/functions-js';
export * from '@supabase/realtime-js';
export { default as SupabaseClient } from './SupabaseClient';
export type { SupabaseClientOptions, QueryResult, QueryData, QueryError } from './lib/types';
/**
 * Creates a new Supabase Client.
 */
export declare const createClient: <Database = any, ClientOptions extends import("@supabase/postgrest-js").ClientServerOptions = GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["options"], SchemaName extends string & keyof GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["db"] = "public" extends keyof GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["db"] ? "public" : string & keyof GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["db"], Schema = GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["db"][SchemaName] extends GenericSchema ? GetGenericDatabaseWithOptions<Database, {
    PostgrestVersion: "12";
}>["db"][SchemaName] : any>(supabaseUrl: string, supabaseKey: string, options?: SupabaseClientOptions<SchemaName> | undefined) => SupabaseClient<Database, ClientOptions, SchemaName, Schema extends GenericSchema ? Schema : any>;
//# sourceMappingURL=index.d.ts.map