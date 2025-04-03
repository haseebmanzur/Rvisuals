# Load the pheatmap package
library(pheatmap)

# Load the data matrix
species <- read.csv("E:/Amphora2/amphora2_results/matrix_result_species_only.csv", header = TRUE, row.names = 1)

# Sort the data table
species_sorted <- species[order(-rowSums(species)), ]

# Extract the top 50 rows
data_matrix <- species_sorted[1:25, ]

# Define a beautiful color scheme
my_color_scheme <- colorRampPalette(c("steelblue", "#91bfdb", "#e0f3f8", "#fee08b", "#d73027"))(100)

# Read the metadata file
metadata <- read.csv("E:/metadata.csv", header = TRUE)

# Check if metadata columns 'Sample' and 'Group' exist
if (!all(c("Sample", "Group") %in% colnames(metadata))) {
  stop("Metadata file must contain 'Sample' and 'Group' columns.")
}

# Ensure that sample names in metadata match the column names in the data matrix
if (!all(metadata$Sample %in% colnames(data_matrix))) {
  stop("Not all sample names in metadata match column names in data matrix.")
}

# Create a data frame for column annotations
annotation_col <- data.frame(Group = metadata$Group)
rownames(annotation_col) <- metadata$Sample

# Match the order of the columns in the data matrix to the annotation
annotation_col <- annotation_col[colnames(data_matrix), , drop = FALSE]

# Define specific colors for each group in annotations
group_colors <- c(
  "Premenopause_Control" = "#7FC7D9",
  "Premenopause_Case" = "#9AD0C2",
  "Postmenopause_Control" = "#AE93BEFF",
  "Postmenopause_Case" = "#E7A79BFF"
)
annotation_colors <- list(Group = group_colors)

# Create the heatmap with annotations
pheatmap(
  data_matrix,
  color = my_color_scheme,
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  cluster_cols = TRUE,  # Enable column clustering
  cluster_rows = TRUE,  # Disable row clustering
  fontsize_row = 7,
  fontsize_col = 7,
  scale = "column",
  cellwidth = 9,  # Adjust the width of each cell
  cellheight = 9,  # Adjust the height of each cell
  annotation_col = annotation_col,  # Add the annotation
  annotation_colors = annotation_colors,  # Add colors for the annotation
  show_colnames = FALSE  # Hide column names (sample names)
)

