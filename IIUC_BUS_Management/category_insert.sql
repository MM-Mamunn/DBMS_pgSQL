
	
--category_insert function 
CREATE OR REPLACE FUNCTION public.category_insert(
	param jsonb,
	OUT _out jsonb)
    RETURNS jsonb
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
     
    _category varchar := coalesce((param->>'category')::varchar,'');
   _seats INTEGER :=coalesce( (param->>'seats')::INTEGER,0); 
   _oil NUMERIC:= coalesce((param->>'oil')::NUMERIC,0);
	_salary NUMERIC := coalesce((param->>'salary')::NUMERIC,0);
	
    
	_json jsonb := '{}'::jsonb;
	
begin
    _out := '{}';
	
	INSERT INTO category(category,seats,oil,salary)
		VALUES
 		(_category,_seats,_oil,_salary);
		
end;
$BODY$;

ALTER FUNCTION public.category_insert(jsonb)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.category_insert(jsonb) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.category_insert(jsonb) TO postgres WITH GRANT OPTION;


---query
SELECT public.category_insert(
	'{"category":"large", "seats":"75", "oil":"0.3","salary":"2200"}'::jsonb
)
select * from category