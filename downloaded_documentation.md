[1]Powered by Devin
   [2]DeepWiki
   [3]DeepWiki

   [4]karpathy/nanoGPT
   [5]powered by
   Devin
   (BUTTON) Share
   Last indexed: 18 April 2025 ([6]93a43d)
     * [7]Overview
     * [8]Installation and Requirements
     * [9]Repository Structure
     * [10]Model Architecture
     * [11]GPT Configuration
     * [12]Attention Mechanism
     * [13]Text Generation
     * [14]Training System
     * [15]Training Loop
     * [16]Optimizer Configuration
     * [17]Distributed Training
     * [18]Data Preparation
     * [19]OpenWebText Dataset
     * [20]Shakespeare Datasets
     * [21]Using nanoGPT
     * [22]Training a Model
     * [23]Text Generation
     * [24]Benchmarking
     * [25]Fine-tuning
     * [26]Configuration System
     * [27]Configuration Files
     * [28]Configuration Overrides
     * [29]Advanced Topics
     * [30]Scaling Laws
     * [31]Performance Optimization

   Menu

Data Preparation (BUTTON)

   Relevant source files
     * [32]data/openwebtext/prepare.py
     * [33]data/shakespeare/prepare.py
     * [34]data/shakespeare_char/prepare.py

Purpose and Scope (BUTTON)

   This document explains how raw text data is prepared for training
   language models in nanoGPT. It covers the data preparation pipeline,
   the format of processed data, and the specific preparation scripts
   included in the repository. For information about how this data is used
   during training, see [35]Training System.

Overview (BUTTON)

   Data preparation in nanoGPT transforms raw text into tokenized binary
   files that can be efficiently loaded during model training. The
   repository includes preparation scripts for several datasets, each
   following a similar pattern but with dataset-specific adaptations.

   Sources: [36]data/openwebtext/prepare.py
   [37]data/shakespeare_char/prepare.py [38]data/shakespeare/prepare.py

Data Format and Storage (BUTTON)

   All datasets are prepared and stored as arrays of integer token IDs in
   binary files:
     * Training data is stored in train.bin files
     * Validation data is stored in val.bin files
     * The data type is typically np.uint16 since the maximum token ID in
       GPT-2's vocabulary is less than 2^16

   During training, these binary files are memory-mapped for efficient
   access, allowing the system to train on datasets that might not fit
   entirely in memory.
   Dataset Training Tokens Validation Tokens Training File Size Format
   OpenWebText ~9B ~4M ~17GB GPT-2 BPE tokens
   Shakespeare (char) ~1M ~111K Small Character-level
   Shakespeare (word) ~302K ~36K Small GPT-2 BPE tokens

   Sources: [39]data/openwebtext/prepare.py76-78
   [40]data/shakespeare_char/prepare.py63-68
   [41]data/shakespeare/prepare.py32-33

Dataset-Specific Preparation (BUTTON)

OpenWebText Dataset (BUTTON)

   The OpenWebText dataset is a large corpus of text from the web, similar
   to the dataset used to train the original GPT-2 model.

   The preparation process:
    1. Loads the dataset using HuggingFace datasets library
    2. Creates a small validation split (0.05% of the data)
    3. Tokenizes the text using the GPT-2 BPE tokenizer via tiktoken
    4. Appends an end-of-text token to each document
    5. Concatenates all tokens and saves them as memory-mapped binary
       files

   Sources: [42]data/openwebtext/prepare.py21-74

Shakespeare Character-level Dataset (BUTTON)

   This preparation treats each character as a token:

   Key characteristics:
     * Vocabulary size: 65 (unique characters)
     * Simple integer mapping for each character
     * Metadata (character-to-ID mapping) saved in meta.pkl for
       encoding/decoding
     * 90/10 train/validation split

   Sources: [43]data/shakespeare_char/prepare.py1-68

Shakespeare Token-level Dataset (BUTTON)

   This preparation uses the standard GPT-2 BPE tokenizer:

   The process:
    1. Downloads the tiny Shakespeare dataset
    2. Splits data into training (90%) and validation (10%)
    3. Tokenizes using tiktoken's GPT-2 encoding
    4. Saves the encoded data as binary files

   Sources: [44]data/shakespeare/prepare.py1-33

Data Usage in Training (BUTTON)

   The prepared binary data files are used by the training script
   (train.py), which:

   The memory-mapped approach allows for efficient random access to the
   token sequences during batch creation, without requiring the entire
   dataset to be loaded into memory.

Custom Dataset Preparation (BUTTON)

   To prepare a custom dataset for nanoGPT, follow these general steps:
    1. Load or download your text data
    2. Choose a tokenization method:
          + GPT-2 BPE tokenization (recommended for most cases)
          + Character-level tokenization (for smaller datasets or specific
            applications)
    3. Tokenize the text and convert to integer IDs
    4. Split into training and validation sets
    5. Save as binary files using numpy's tofile() or memory-mapped arrays

   The binary format allows nanoGPT's training process to efficiently load
   and process the data, regardless of dataset size.

   Auto-refresh not enabled yet

   Try DeepWiki on your private codebase with [45]Devin

On this page

     * [46]Data Preparation
     * [47]Purpose and Scope
     * [48]Overview
     * [49]Data Format and Storage
     * [50]Dataset-Specific Preparation
     * [51]OpenWebText Dataset
     * [52]Shakespeare Character-level Dataset
     * [53]Shakespeare Token-level Dataset
     * [54]Data Usage in Training
     * [55]Custom Dataset Preparation

References

   1. https://devin.ai/
   2. https://deepwiki.com/
   3. https://deepwiki.com/
   4. https://github.com/karpathy/nanoGPT
   5. https://devin.ai/
   6. https://github.com/karpathy/nanoGPT/commits/93a43d9a
   7. https://deepwiki.com/karpathy/nanoGPT/1-overview
   8. https://deepwiki.com/karpathy/nanoGPT/1.1-installation-and-requirements
   9. https://deepwiki.com/karpathy/nanoGPT/1.2-repository-structure
  10. https://deepwiki.com/karpathy/nanoGPT/2-model-architecture
  11. https://deepwiki.com/karpathy/nanoGPT/2.1-gpt-configuration
  12. https://deepwiki.com/karpathy/nanoGPT/2.2-attention-mechanism
  13. https://deepwiki.com/karpathy/nanoGPT/2.3-text-generation
  14. https://deepwiki.com/karpathy/nanoGPT/3-training-system
  15. https://deepwiki.com/karpathy/nanoGPT/3.1-training-loop
  16. https://deepwiki.com/karpathy/nanoGPT/3.2-optimizer-configuration
  17. https://deepwiki.com/karpathy/nanoGPT/3.3-distributed-training
  18. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation
  19. https://deepwiki.com/karpathy/nanoGPT/4.1-openwebtext-dataset
  20. https://deepwiki.com/karpathy/nanoGPT/4.2-shakespeare-datasets
  21. https://deepwiki.com/karpathy/nanoGPT/5-using-nanogpt
  22. https://deepwiki.com/karpathy/nanoGPT/5.1-training-a-model
  23. https://deepwiki.com/karpathy/nanoGPT/5.2-text-generation
  24. https://deepwiki.com/karpathy/nanoGPT/5.3-benchmarking
  25. https://deepwiki.com/karpathy/nanoGPT/5.4-fine-tuning
  26. https://deepwiki.com/karpathy/nanoGPT/6-configuration-system
  27. https://deepwiki.com/karpathy/nanoGPT/6.1-configuration-files
  28. https://deepwiki.com/karpathy/nanoGPT/6.2-configuration-overrides
  29. https://deepwiki.com/karpathy/nanoGPT/7-advanced-topics
  30. https://deepwiki.com/karpathy/nanoGPT/7.1-scaling-laws
  31. https://deepwiki.com/karpathy/nanoGPT/7.2-performance-optimization
  32. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/openwebtext/prepare.py
  33. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare/prepare.py
  34. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare_char/prepare.py
  35. https://deepwiki.com/karpathy/nanoGPT/3-training-system
  36. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/openwebtext/prepare.py
  37. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare_char/prepare.py
  38. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare/prepare.py
  39. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/openwebtext/prepare.py#L76-L78
  40. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare_char/prepare.py#L63-L68
  41. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare/prepare.py#L32-L33
  42. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/openwebtext/prepare.py#L21-L74
  43. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare_char/prepare.py#L1-L68
  44. https://github.com/karpathy/nanoGPT/blob/93a43d9a/data/shakespeare/prepare.py#L1-L33
  45. https://deepwiki.com/private-repo
  46. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#data-preparation
  47. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#purpose-and-scope
  48. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#overview
  49. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#data-format-and-storage
  50. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#dataset-specific-preparation
  51. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#openwebtext-dataset
  52. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#shakespeare-character-level-dataset
  53. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#shakespeare-token-level-dataset
  54. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#data-usage-in-training
  55. https://deepwiki.com/karpathy/nanoGPT/4-data-preparation#custom-dataset-preparation
