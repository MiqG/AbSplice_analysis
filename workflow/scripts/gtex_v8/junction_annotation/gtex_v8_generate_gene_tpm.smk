from absplice_scripts.data.gtex_v8 import tissue_map, tissue_map_gene_expr
import pandas as pd

rule gtex_v8_generate_gene_tpm:
    input:
        gene_expression_raw = config['gene_expression']['raw'],
    params:
        tissue_map = tissue_map_gene_expr,
    output:
        gene_tpm_wide = OUTPUT_DIR_JUNCTION_ANNO + config_static['junction_annotation']['gene_tpm_wide'],
        gene_tpm = OUTPUT_DIR_JUNCTION_ANNO + config_static['junction_annotation']['gene_tpm'],
    script:
        "./generate_gene_tpm_gtex.py"
        
        
rule gtex_v8_generate_tissue_map:
    output:
        tissue_map = config['DROP']['tissue_map'],
    run:
        df = pd.DataFrame(tissue_map, index=[0]).transpose().reset_index().rename(columns={'index': 'tissue', 0: 'tissue_DROP'})
        df.to_csv(output.tissue_map, index=False)
        