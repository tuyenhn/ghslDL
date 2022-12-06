## code to prepare `DATASET` dataset goes here
# nolint start
datasets <- data.frame(
    name = c(
        "GHS-BUILT-S",
        "GHS-BUILT-H_AGBH",
        "GHS-BUILT-H_ANBH",
        "GHS-BUILT-V",
        "GHS-BUILT-C_FUN",
        "GHS-BUILT-C_MSZ",
        "GHS-BUILT-C_VEG",
        "GHS-POP"
    ),
    description = c(
        "The distribution of built-up surfaces, expressed as number of square meters",
        "The spatial distribution of the building heights per cell. Average of the Gross Building Height",
        "The spatial distribution of the building heights per cell. Average of the Net Building Height",
        "The distribution of built-up volumes, expressed as number of cubic meters",
        "Morphological Settlement Zone delineation and inner classification",
        "RES vs. NRES functional classification of the built domain defined as BUFRAC>0",
        "Vegetation intensity in the Morphological Settlement Zone",
        "The distribution of population, expressed as the number of people per cell"
    ),
    folder_url = c(
        "GHS_BUILT_S_GLOBE_R2022A/GHS_BUILT_S_GLOBE_R2022A",
        "GHS_BUILT_H_GLOBE_R2022A/GHS_BUILT_H_AGBH_GLOBE_R2022A",
        "GHS_BUILT_H_GLOBE_R2022A/GHS_BUILT_H_ANBH_GLOBE_R2022A",
        "GHS_BUILT_V_GLOBE_R2022A/GHS_BUILT_V_GLOBE_R2022A",
        "GHS_BUILT_C_GLOBE_R2022A/GHS_BUILT_C_FUN_GLOBE_R2022A",
        "GHS_BUILT_C_GLOBE_R2022A/GHS_BUILT_C_MSZ_GLOBE_R2022A",
        "GHS_BUILT_C_GLOBE_R2022A/GHS_BUILT_C_VEG_GLOBE_R2022A",
        "GHS_POP_GLOBE_R2022A"
    )
)
# nolint end

usethis::use_data(datasets, overwrite = TRUE, internal = TRUE)
