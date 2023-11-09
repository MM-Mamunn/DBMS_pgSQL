
CREATE OR REPLACE FUNCTION public.driver_insert(
	param jsonb,
	OUT _out jsonb)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
     
    _driver_id varchar := coalesce((param->>'driver_id')::varchar,'');
   _name varchar :=coalesce( (param->>'name')::varchar,''); 
   _age INTEGER:= coalesce((param->>'age')::INTEGER,0);
	_license_no varchar := coalesce((param->>'license_no')::varchar,'');
	
    
	_json jsonb := '{}'::jsonb;
	
begin
    _out := '{}';
	
	INSERT INTO driver(driver_id,name,age,license_no)
		VALUES
 		(_driver_id,_name,_age,_license_no);
		
end;
$BODY$;

ALTER FUNCTION public.driver_insert(jsonb)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.driver_insert(jsonb) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.driver_insert(jsonb) TO postgres WITH GRANT OPTION;
