# Load necessary libraries
library(tidyr)
library(ggplot2)
library(stats)
library(tidyverse)
library(dplyr)
library(ggpubr)  # for geom_signif
library(ggrain)

# Load the data from your CSV file
df <- read.csv("E:/FYP_metadata.csv")
head(df)
str(df)

# *********Raw reads Distribution Raw*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "Raw"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "Raw"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "Raw"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "Raw"]

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

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Raw reads", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "Raw reads", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "Raw reads", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "Raw reads", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create the plot with adjustments
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  ggdist::stat_dist_halfeye(
    adjust = 0.55,  # Reduce the width of the half-eye plots
    justification = -.11,  # Slightly increase the justification to spread out the dots more
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .11,  # Slightly narrow the boxplot width
    outlier.color = NA,
    alpha = 0.5,
    notch = FALSE
  ) +
  ggdist::stat_dist_dots(
    side = "left",
    justification = 1.12,  # Increase justification to space out the dots further
    binwidth = 0.4,  # Increase the binwidth to reduce congestion
    
  ) +
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(
    x = NULL,
    y = "Read Count (Mbps)",
    fill = "Group"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside"
  ) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

print(p)



# *********Clean reads Distribution Clean*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "Clean"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "Clean"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "Clean"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "Clean"]

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

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "Clean reads", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "Clean reads", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "Clean reads", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "Clean reads", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create the plot with adjustments
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  ggdist::stat_dist_halfeye(
    adjust = 0.55,  # Reduce the width of the half-eye plots
    justification = -.11,  # Slightly increase the justification to spread out the dots more
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .11,  # Slightly narrow the boxplot width
    outlier.color = NA,
    alpha = 0.5,
    notch = FALSE
  ) +
  ggdist::stat_dist_dots(
    side = "left",
    justification = 1.12,  # Increase justification to space out the dots further
    binwidth = 0.4,  # Increase the binwidth to reduce congestion
    
  ) +
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(
    x = NULL,
    y = "Read Count (Mbps)",
    fill = "Group"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside"
  ) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

print(p)



# *********HG_trimmed reads Distribution HG_trimmed*********#

# Subset the data for Premenopause Control, Premenopause Case, Postmenopause Control, and Postmenopause Case
premenopause_control_data <- df[df$Group == "Premenopause Control", "HG_trimmed"]
premenopause_case_data <- df[df$Group == "Premenopause Case", "HG_trimmed"]
postmenopause_control_data <- df[df$Group == "Postmenopause Control", "HG_trimmed"]
postmenopause_case_data <- df[df$Group == "Postmenopause Case", "HG_trimmed"]

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

# Combine the data for visualization
combined_data <- rbind(
  data.frame(Group = "Premenopause Control", Variable = "HG trimmed reads", Value = premenopause_control_data),
  data.frame(Group = "Premenopause Case", Variable = "HG trimmed reads", Value = premenopause_case_data),
  data.frame(Group = "Postmenopause Control", Variable = "HG trimmed reads", Value = postmenopause_control_data),
  data.frame(Group = "Postmenopause Case", Variable = "HG trimmed reads", Value = postmenopause_case_data)
)

# Rearrange levels 
combined_data$Group <- factor(combined_data$Group, levels = c("Premenopause Control", "Premenopause Case", "Postmenopause Control", "Postmenopause Case"))

# Create the plot with adjustments
p <- ggplot(combined_data, aes(x = Group, y = Value, fill = Group)) +
  ggdist::stat_dist_halfeye(
    adjust = 0.55,  # Reduce the width of the half-eye plots
    justification = -.11,  # Slightly increase the justification to spread out the dots more
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = .11,  # Slightly narrow the boxplot width
    outlier.color = NA,
    alpha = 0.5,
    notch = FALSE
  ) +
  ggdist::stat_dist_dots(
    side = "left",
    justification = 1.12,  # Increase justification to space out the dots further
    binwidth = 0.4,  # Increase the binwidth to reduce congestion
    
  ) +
  scale_fill_manual(values = c("Premenopause Control" = "#7FC7D9", "Premenopause Case" = "#9AD0C2", "Postmenopause Control" = "#AE93BEFF", "Postmenopause Case" = "#E7A79BFF")) +
  labs(
    x = NULL,
    y = "Read Count (Mbps)",
    fill = "Group"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5),
    strip.background = element_rect(color = "black", fill = "lightgray", size = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    strip.placement = "outside"
  ) +
  facet_wrap(~Variable, scales = "free_x", ncol = 3)

print(p)