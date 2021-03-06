Feature: BGZF compression
  Because MAF files are large
  We need random access
  But we would also like to compress them
  Yet common compression formats don't facilitate random access
  So we use BGZF compression to support random access
  To 64 KB chunks

  @no_jruby
  Scenario: Compress a MAF file
    Given test files:
    | mm8_chr7_tiny.maf |
    When I run `maf_bgzip mm8_chr7_tiny.maf`
    Then it should pass with:
    """
    """
    And a file named "mm8_chr7_tiny.maf.bgz" should exist
    
  @no_jruby
  Scenario: Compress and index a MAF file
    Given test files:
    | mm8_chr7_tiny.maf |
    When I run `maf_bgzip -i mm8_chr7_tiny.maf`
    Then it should pass with:
    """
    """
    And a file named "mm8_chr7_tiny.maf.bgz" should exist
    And a file named "mm8_chr7_tiny.kct" should exist
    
  @no_jruby
  Scenario: Compress a gzipped MAF file
    Given test files:
    | mm8_chr7_tiny.maf.gz |
    When I run `maf_bgzip mm8_chr7_tiny.maf.gz`
    Then it should pass with:
    """
    """
    And a file named "mm8_chr7_tiny.maf.bgz" should exist
    
  @no_jruby
  Scenario: Compress and index a gzipped MAF file
    Given test files:
    | mm8_chr7_tiny.maf.gz |
    When I run `maf_bgzip -i mm8_chr7_tiny.maf.gz`
    Then it should pass with:
    """
    """
    And a file named "mm8_chr7_tiny.maf.bgz" should exist
    And a file named "mm8_chr7_tiny.kct" should exist
    
  @no_jruby
  Scenario: Compress multiple MAF files
    Given test files:
    | mm8_chr7_tiny.maf |
    | mm8.chrM.maf      |
    When I run `maf_bgzip mm8_chr7_tiny.maf mm8.chrM.maf`
    Then it should pass with:
    """
    """
    And a file named "mm8_chr7_tiny.maf.bgz" should exist
    And a file named "mm8.chrM.maf.bgz" should exist
    
  @no_jruby
  Scenario: Don't overwrite MAF files
    Given test files:
    | mm8.chrM.maf      |
    | mm8.chrM.maf.bgz  |
    When I run `maf_bgzip mm8.chrM.maf`
    Then it should fail with:
    """
    exists
    """

  @no_jruby
  Scenario: Don't overwrite indexes
    Given test files:
    | mm8_chr7_tiny.maf |
    When I run `maf_bgzip --index mm8_chr7_tiny.maf`
     And I run `rm mm8_chr7_tiny.maf.bgz`
     And I run `maf_bgzip --index mm8_chr7_tiny.maf`
    Then it should fail with:
    """
    exists
    """

  @no_jruby
  Scenario: Overwrite MAF files with --force
    Given test files:
    | mm8.chrM.maf      |
    | mm8.chrM.maf.bgz  |
    When I run `maf_bgzip --force mm8.chrM.maf`
    Then it should pass with:
    """
    """

  @no_jruby
  Scenario: Overwrite indexes with --force
    Given test files:
    | mm8_chr7_tiny.maf |
    When I run `maf_bgzip --index mm8_chr7_tiny.maf`
     And I run `rm mm8_chr7_tiny.maf.bgz`
     And I run `maf_bgzip --force --index mm8_chr7_tiny.maf`
    Then it should pass with:
    """
    """

    
