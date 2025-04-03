# Load necessary libraries
library(tidyr)
library(ggplot2)
library(stats)
library(tidyverse)
library(dplyr)
library(ggpubr)  # for geom_signif

# Load the data from your CSV file
df <- read.csv("D:/FYP_Figures/FYP_metadata.csv")
head(df)
str(df)

# *********assembly distribution N50*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "N50"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "N50"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "N50"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "N50"]

# Perform Wilcoxon tests
wilcoxon_result_premenopause <- wilcox.test(premenopause_control_data, premenopause_case_data)
wilcoxon_result_postmenopause_control <- wilcox.test(postmenopause_control_data, postmenopause_case_data)
wilcoxon_result_premenopause_vs_postmenopause <- wilcox.test(premenopause_control_data, postmenopause_control_data)
wilcoxon_result_premenopause_case_vs_postmenopause_case <- wilcox.test(premenopause_case_data, postmenopause_case_data)

cat("Wilcoxon Test p-value (Premenopause Control vs. Premenopause Case):", wilcoxon_result_premenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Postmenopause Control vs. Postmenopause Case):", wilcoxon_result_postmenopause_control$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Control vs. Postmenopause Control):", wilcoxon_result_premenopause_vs_postmenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Case vs. Postmenopause Case):", wilcoxon_result_premenopause_case_vs_postmenopause_case$p.value, "\n")

# Visualization with Violin Plot and Box Plot
library(ggplot2)

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "N50", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "N50", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "N50", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "N50", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create separate plots for Raw, HG_trimmed, and Clean using facet_wrap
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  geom_violin(scale = "width", trim = FALSE, draw_quantiles = NULL) +
  geom_boxplot(width = 0.08, fill = "gray", position = position_dodge(width = 0.9), alpha = 0.7) +  
  
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(#title = "Comparison of N50 Distribution in Different Group",
    x = NULL,
    y = "Count (K)",
    fill = "Group") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = ("outside"),
  ) +
  theme(plot.margin = margin(1, 1, 1, 1, "cm"),
        plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

p + stat_compare_means(comparisons = list(c("Premenopause Control", "Premenopause Case"), 
                                          c("Postmenopause Control", "Postmenopause Case"), 
                                          c("Premenopause Control", "Postmenopause Control"), 
                                          c("Premenopause Case", "Postmenopause Case")),
                                          
                       method = "wilcox.test", label = "p.format",
                       vjust = 0.1,  # Adjust the vertical position manually
                       tip.length = 0.02,
                       text.angle = 90,
                       hide.ns = TRUE,
                       size = 3.2,
                       aes(label = paste("p =", sprintf("%.4f", stat(test$pformat)))))



# *********assembly distribution no of contigs*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "No_of_contigs"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "No_of_contigs"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "No_of_contigs"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "No_of_contigs"]

# Perform Wilcoxon tests
wilcoxon_result_premenopause <- wilcox.test(premenopause_control_data, premenopause_case_data)
wilcoxon_result_postmenopause_control <- wilcox.test(postmenopause_control_data, postmenopause_case_data)
wilcoxon_result_premenopause_vs_postmenopause <- wilcox.test(premenopause_control_data, postmenopause_control_data)
wilcoxon_result_premenopause_case_vs_postmenopause_case <- wilcox.test(premenopause_case_data, postmenopause_case_data)

cat("Wilcoxon Test p-value (Premenopause Control vs. Premenopause Case):", wilcoxon_result_premenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Postmenopause Control vs. Postmenopause Case):", wilcoxon_result_postmenopause_control$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Control vs. Postmenopause Control):", wilcoxon_result_premenopause_vs_postmenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Case vs. Postmenopause Case):", wilcoxon_result_premenopause_case_vs_postmenopause_case$p.value, "\n")

# Visualization with Violin Plot and Box Plot
library(ggplot2)

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Number of contigs", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "Number of contigs", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "Number of contigs", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "Number of contigs", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create separate plots for Raw, HG_trimmed, and Clean using facet_wrap
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  geom_violin(scale = "width", trim = FALSE, draw_quantiles = NULL) +
  geom_boxplot(width = 0.08, fill = "gray", position = position_dodge(width = 0.9), alpha = 0.7) +  
  
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(#title = "Comparison of No_of_contigs Distribution in Different Group",
    x = NULL,
    y = "Count (K)",
    fill = "Group") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = ("outside"),
  ) +
  theme(plot.margin = margin(1, 1, 1, 1, "cm"),
        plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

p + stat_compare_means(comparisons = list(c("Premenopause Control", "Premenopause Case"), 
                                          c("Postmenopause Control", "Postmenopause Case"), 
                                          c("Premenopause Control", "Postmenopause Control"), 
                                          c("Premenopause Case", "Postmenopause Case")),
                       method = "wilcox.test", label = "p.format",
                       vjust = 0.1,  # Adjust the vertical position manually
                       tip.length = 0.02,
                       text.angle = 90,
                       hide.ns = TRUE,
                       size = 3.2,
                       aes(label = paste("p =", sprintf("%.4f", stat(test$pformat)))))


# *********assembly distribution Larget Contig*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "Largest_contig"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "Largest_contig"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "Largest_contig"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "Largest_contig"]

# Perform Wilcoxon tests
wilcoxon_result_premenopause <- wilcox.test(premenopause_control_data, premenopause_case_data)
wilcoxon_result_postmenopause_control <- wilcox.test(postmenopause_control_data, postmenopause_case_data)
wilcoxon_result_premenopause_vs_postmenopause <- wilcox.test(premenopause_control_data, postmenopause_control_data)
wilcoxon_result_premenopause_case_vs_postmenopause_case <- wilcox.test(premenopause_case_data, postmenopause_case_data)

cat("Wilcoxon Test p-value (Premenopause Control vs. Premenopause Case):", wilcoxon_result_premenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Postmenopause Control vs. Postmenopause Case):", wilcoxon_result_postmenopause_control$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Control vs. Postmenopause Control):", wilcoxon_result_premenopause_vs_postmenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Case vs. Postmenopause Case):", wilcoxon_result_premenopause_case_vs_postmenopause_case$p.value, "\n")

# Visualization with Violin Plot and Box Plot
library(ggplot2)

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Largest contig", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "Largest contig", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "Largest contig", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "Largest contig", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create separate plots for Raw, HG_trimmed, and Clean using facet_wrap
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  geom_violin(scale = "width", trim = FALSE, draw_quantiles = NULL) +
  geom_boxplot(width = 0.08, fill = "gray", position = position_dodge(width = 0.9), alpha = 0.7) +  
  
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(#title = "Comparison of Largest_contig Distribution in Different Group",
    x = NULL,
    y = "Count (K)",
    fill = "Group") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = ("outside"),
  ) +
  theme(plot.margin = margin(1, 1, 1, 1, "cm"),
        plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

p + stat_compare_means(comparisons = list(c("Premenopause Control", "Premenopause Case"), 
                                          c("Postmenopause Control", "Postmenopause Case"), 
                                          c("Premenopause Control", "Postmenopause Control"), 
                                          c("Premenopause Case", "Postmenopause Case")),
                       method = "wilcox.test", label = "p.format",
                       vjust = 0.1,  # Adjust the vertical position manually
                       tip.length = 0.02,
                       text.angle = 90,
                       hide.ns = TRUE,
                       size = 3.2,
                       aes(label = paste("p =", sprintf("%.4f", stat(test$pformat)))))


# *********assembly distribution Total length*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "Total_length"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "Total_length"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "Total_length"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "Total_length"]

# Perform Wilcoxon tests
wilcoxon_result_premenopause <- wilcox.test(premenopause_control_data, premenopause_case_data)
wilcoxon_result_postmenopause_control <- wilcox.test(postmenopause_control_data, postmenopause_case_data)
wilcoxon_result_premenopause_vs_postmenopause <- wilcox.test(premenopause_control_data, postmenopause_control_data)
wilcoxon_result_premenopause_case_vs_postmenopause_case <- wilcox.test(premenopause_case_data, postmenopause_case_data)

cat("Wilcoxon Test p-value (Premenopause Control vs. Premenopause Case):", wilcoxon_result_premenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Postmenopause Control vs. Postmenopause Case):", wilcoxon_result_postmenopause_control$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Control vs. Postmenopause Control):", wilcoxon_result_premenopause_vs_postmenopause$p.value, "\n")
cat("Wilcoxon Test p-value (Premenopause Case vs. Postmenopause Case):", wilcoxon_result_premenopause_case_vs_postmenopause_case$p.value, "\n")

# Visualization with Violin Plot and Box Plot
library(ggplot2)

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Total length", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "Total length", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "Total length", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "Total length", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create separate plots for Raw, HG_trimmed, and Clean using facet_wrap
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  geom_violin(scale = "width", trim = FALSE, draw_quantiles = NULL) +
  geom_boxplot(width = 0.08, fill = "gray", position = position_dodge(width = 0.9), alpha = 0.7) +  
  
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(#title = "Comparison of Total_length Distribution in Different Group",
    x = NULL,
    y = "Count (M)",
    fill = "Group") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = ("outside"),
  ) +
  theme(plot.margin = margin(1, 1, 1, 1, "cm"),
        plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

p + stat_compare_means(comparisons = list(c("Premenopause Control", "Premenopause Case"), 
                                          c("Postmenopause Control", "Postmenopause Case"), 
                                          c("Premenopause Control", "Postmenopause Control"), 
                                          c("Premenopause Case", "Postmenopause Case")),
                       method = "wilcox.test", label = "p.format",
                       vjust = 0.1,  # Adjust the vertical position manually
                       tip.length = 0.02,
                       text.angle = 90,
                       hide.ns = TRUE,
                       size = 3.2,
                       aes(label = paste("p =", sprintf("%.4f", stat(test$pformat)))))


