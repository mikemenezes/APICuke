Feature: Test Case to validate the API
  Scenario Outline: Sample to test the search API
    Given  I have a validation token
    And the query parameter is "<query>"
    And the sort parameter is "<sort>"
    And the limit parameter is <limit>
    And the function is GET
    When I call the search API
    Then I get the return code <code> and <elements>
    Examples:
    |code|elements|query|sort|limit|
    |200 |1       |12342|    |     |
    |200 |5       ||         |     |
    |200 |2       |human|    |     |
    |200 |1       |lovely|   |     |
    |404 |0       |nonExisting||   |
    |400 |0       |moreThanFiftyCharactersInTheSearchmoreThanFiftyCharactersInTheSearchmoreThanFiftyCharactersInTheSearch|||
    |200 |1       |                                                                                                      ||1|
    |200 |3       |                                                                                                      ||3|
    |200 |5       |                                                                                                      ||5|
    |200 |5       |                                                                                                      ||10|
    |200 |5       |                                                                                                      ||20|
    |200 |0       |                                                                                                      ||0|
    |200 |0       |                                                                                                      ||-1|
    |200 |0       |                                                                                                      ||hi|
    |200 |2       |red                                                                                                   |asc|2|
    |404 |0       |nonExist                                                                                              |asc|2|



  Scenario Outline: Validate the search HEAD API
    Given I have a validation token
    And the query parameter is "<query>"
    And the function is HEAD
    When I call the search API
    Then I get the return code <code> and <elements>
    Examples:
    |query|code|elements|
    |12342|200 |0       |
    ||200 |0       |
    |human|200 |0       |
    |lovely|200 |0       |
    |nonExisting|404 |0       |
    |moreThanFiftyCharactersInTheSearchmoreThanFiftyCharactersInTheSearchmoreThanFiftyCharactersInTheSearch|400 |0       |

Scenario Outline: Validate the Retrieve asset GET API
  Given I have a validation token
  And the asset parameter is <asset_id>
  And the function is GET
  When I call the asset API
  Then I get the asset return code <code> and <assets>
  Examples:
  |code|asset_id|assets|
  |200 ||5|
  |200 |12342|1|
  |404 |1234567|0|
  |404 |-1|0|
  |404 |hello|0|

  Scenario Outline: Validate the Retrieve asset HEAD API
    Given I have a validation token
    And the asset parameter is <asset_id>
    And the function is HEAD
    When I call the asset API
    Then I get the asset return code <code> and <assets>
    Examples:
      |code|asset_id|assets|
      |200 ||0|
      |200 |12342|0|
      |404 |1234567|0|
      |404 |-1|0|
