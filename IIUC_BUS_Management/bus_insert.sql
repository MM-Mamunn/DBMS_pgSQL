--bus_insert function 
CREATE OR REPLACE FUNCTION public.bus_insert(
	param jsonb,
	OUT _out jsonb)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
     
    _bus_id varchar := coalesce((param->>'bus_id')::varchar,'');
   _category varchar :=coalesce( (param->>'category')::varchar,''); 
   _license_no varchar := coalesce((param->>'license_no')::varchar,'');
	_assign varchar := coalesce((param->>'assign')::varchar,'');
	--(bus_id varchar(20),category varchar(30),license_no varchar(30),assign varchar(30))
    
	_json jsonb := '{}'::jsonb;
	
begin
    _out := '{}';
	
	INSERT INTO bus(bus_id,category,license_no,assign)
		VALUES
 		(_bus_id,_category,_license_no,_assign);
		
end;
$BODY$;

ALTER FUNCTION public.bus_insert(jsonb)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.bus_insert(jsonb) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.bus_insert(jsonb) TO postgres WITH GRANT OPTION;


---query
SELECT public.bus_insert(
	'{"bus_id":"11", "category":"medium", "license_no":"CTG-LA 11-1899","assign":"staff"}'::jsonb
)
select * from bus