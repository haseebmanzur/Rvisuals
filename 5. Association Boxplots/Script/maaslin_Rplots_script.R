# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
library(patchwork)  # Load patchwork library

#############################   Bacteroides_uniformis CD   #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/bacteroides_uniformis_cd_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/cd_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/bacteroides_uniformis_cd_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Bacteroides_uniformis") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "CD"))

# Add a new column for custom facet label
custom_label <- "Bacteroides uniformis"
merged_data$FacetLabel <- custom_label


# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "CD" = "#CC99A7")
jitter_colors <- c("Healthy" = "#6F8C99", "CD" = "#A87C7C")

# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Bacteroides_uniformis, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Bacteroides_uniformis, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)



#############################   Eubacterium_rectales  CD #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/eubacterium_rectale_cd_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/cd_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/eubacterium_rectale_cd_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Eubacterium_rectale") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "CD"))

# Add a new column for custom facet label
custom_label <- "Eubacterium rectale"
merged_data$FacetLabel <- custom_label

# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "CD" = "#CC99A7")
jitter_colors <- c("Healthy" = "#6F8C99", "CD" = "#A87C7C")


# Define colors
# boxplot_colors <- c("Healthy" = "#A3B1BB", "CD" = "#CC99A7")
# jitter_colors <- c("Healthy" = "#5C7285", "CD" = "#A87C7C")

# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Eubacterium_rectale, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Eubacterium_rectale, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)

#############################   Bacteroides_vulgatus CD   #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/bacteroides_vulgatus_cd_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/cd_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/cd/bacteroides_vulgatus_cd_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Bacteroides_vulgatus") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "CD"))

# Add a new column for custom facet label
custom_label <- "Bacteroides vulgatus"
merged_data$FacetLabel <- custom_label

# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "CD" = "#CC99A7")
jitter_colors <- c("Healthy" = "#6F8C99", "CD" = "#A87C7C")


# Define colors
# boxplot_colors <- c("Healthy" = "#A3B1BB", "CD" = "#CC99A7")
# jitter_colors <- c("Healthy" = "#5C7285", "CD" = "#A87C7C")

# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Bacteroides_vulgatus, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Bacteroides_vulgatus, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)



#############################   Bacteroides_uniformis UC   #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/bacteroides_uniformis_uc_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/uc_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/bacteroides_uniformis_uc_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Bacteroides_uniformis") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "UC"))

# Add a new column for custom facet label
custom_label <- "Bacteroides uniformis"
merged_data$FacetLabel <- custom_label


# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "UC" = "#B7C3A4")
jitter_colors <- c("Healthy" = "#6F8C99", "UC" = "#739072")


# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Bacteroides_uniformis, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Bacteroides_uniformis, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)




#############################   Eubacterium_rectales  UC #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/eubacterium_rectale_uc_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/uc_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/eubacterium_rectale_uc_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Eubacterium_rectale") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "UC"))

# Add a new column for custom facet label
custom_label <- "Eubacterium rectale"
merged_data$FacetLabel <- custom_label

# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "UC" = "#B7C3A4")
jitter_colors <- c("Healthy" = "#6F8C99", "UC" = "#739072")

# Define colors
# boxplot_colors <- c("Healthy" = "#A3B1BB", "CD" = "#CC99A7")
# jitter_colors <- c("Healthy" = "#5C7285", "CD" = "#A87C7C")

# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Eubacterium_rectale, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Eubacterium_rectale, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)

#############################   Bacteroides_vulgatus UC   #########################
# Read the data
abundance_data <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/bacteroides_vulgatus_uc_abundance.csv")
metadata <- read.csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/uc_metadata.csv")
significant_results <- read_csv("C:/Users/HP/Downloads/nadeem_maaslin/maaslin/inputs/uc/bacteroides_vulgatus_uc_significant.csv")

# Merge data if necessary
merged_data <- merge(abundance_data, metadata, by = "Sample")

# Ensure necessary columns are present
if (!all(c("Phenotype", "Bacteroides_vulgatus") %in% colnames(merged_data))) {
  stop("Required columns are missing in the merged data.")
}

# Reorder Phenotype levels to ensure "Healthy" appears first
merged_data$Phenotype <- factor(merged_data$Phenotype, levels = c("Healthy", "UC"))

# Add a new column for custom facet label
custom_label <- "Bacteroides vulgatus"
merged_data$FacetLabel <- custom_label

# Define colors
boxplot_colors <- c("Healthy" = "#A5BFCC", "UC" = "#B7C3A4")
jitter_colors <- c("Healthy" = "#6F8C99", "UC" = "#739072")



# Define colors
# boxplot_colors <- c("Healthy" = "#A3B1BB", "CD" = "#CC99A7")
# jitter_colors <- c("Healthy" = "#5C7285", "CD" = "#A87C7C")

# Plotting
ggplot(merged_data, aes(x = Phenotype, y = Bacteroides_vulgatus, fill = Phenotype)) +
  geom_boxplot(width = 0.6, outlier.shape = NA) +
  geom_jitter(aes(color = Phenotype), width = 0.2, size = 2.5, alpha = 0.7) +
  scale_fill_manual(values = boxplot_colors) +
  scale_color_manual(values = jitter_colors) +
  labs(y = "Relative Abundance", x = NULL, fill = "Phenotype", color = "Phenotype") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside",
    plot.margin = margin(1, 1, 1, 1, "cm"),
    plot.title = element_text(hjust = 0.5)
  ) +
  facet_wrap(~FacetLabel, strip.position = "top") +
  annotate("text",
           x = 1.5,
           y = max(merged_data$Bacteroides_vulgatus, na.rm = TRUE) * 1.05,
           label = paste("FDR:", significant_results$FDR[1],
                         "\nCoefficient:", significant_results$Coefficient[1],
                         "\nValue:", significant_results$Value[1]),
           hjust = 0.5,
           vjust = 0.8,
           size = 3)

