import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://cepecepyxyoguuturlod.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlcGVjZXB5eHlvZ3V1dHVybG9kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIwNTYzMDIsImV4cCI6MjA2NzYzMjMwMn0.k1pyw2_ttJTHCPz1UYMPnZ26EcwKjEqqEMDVgUNcCoc';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
