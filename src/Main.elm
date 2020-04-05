module Main exposing (main)

import Browser
import Helpers
import Html exposing (Html, a, button, div, form, h3, img, input, label, text)
import Html.Attributes exposing (alt, class, href, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Meal =
    { name : String
    , imageUrl : String
    , recipeUrl : String
    }


type alias Model =
    { meals : List (Maybe Meal)
    , mealNameInput : String
    , mealImageUrlInput : String
    , mealRecipeUrlInput : String
    }


init : Model
init =
    { meals = []
    , mealNameInput = ""
    , mealImageUrlInput = ""
    , mealRecipeUrlInput = ""
    }


type Msg
    = AddMeal
    | SetMealName String
    | SetMealImageUrl String
    | SetMealRecipeUrl String
    | CreateMeal


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddMeal ->
            { model
                | meals =
                    Helpers.updateListItem
                        (List.length model.meals - 1)
                        (Just
                            { name = model.mealNameInput
                            , imageUrl = model.mealImageUrlInput
                            , recipeUrl = model.mealRecipeUrlInput
                            }
                        )
                        model.meals
                , mealNameInput = ""
                , mealImageUrlInput = ""
                , mealRecipeUrlInput = ""
            }

        SetMealName s ->
            { model | mealNameInput = s }

        SetMealImageUrl s ->
            { model | mealImageUrlInput = s }

        SetMealRecipeUrl s ->
            { model | mealRecipeUrlInput = s }

        CreateMeal ->
            { model | meals = Helpers.addToList Nothing model.meals }


addMealView : Model -> Html Msg
addMealView model =
    form [ onSubmit AddMeal, class "flex flex-col p-8 mx-auto bg-white border shadow-md" ]
        [ label
            [ class "flex flex-col my-4" ]
            [ input
                [ onInput SetMealName, value model.mealNameInput, type_ "text", class "p-4 border" ]
                []
            , text "Meal Name"
            ]
        , label
            [ class "flex flex-col my-4" ]
            [ input
                [ onInput SetMealImageUrl, value model.mealImageUrlInput, type_ "text", class "p-4 border" ]
                []
            , text "Meal Image"
            ]
        , label
            [ class "flex flex-col my-4" ]
            [ input
                [ onInput SetMealRecipeUrl, value model.mealRecipeUrlInput, type_ "text", class "p-4 border" ]
                []
            , text "Meal Recipe"
            ]
        , button [ type_ "submit", class "p-4 my-4 border" ] [ text "Add Meal to List" ]
        ]


mealDetailsView : Meal -> Html Msg
mealDetailsView meal =
    div [ class "p-8 mx-auto bg-white border shadow-md" ]
        [ img [ src meal.imageUrl, alt meal.name ] []
        , h3 [ class "text-2xl" ] [ text meal.name ]
        , a
            [ href meal.recipeUrl
            , class "underline hover:text-gray-700"
            ]
            [ text "Recipe" ]
        ]


mealCardView : Model -> Maybe Meal -> Html Msg
mealCardView model meal =
    case meal of
        Nothing ->
            addMealView model

        Just m ->
            mealDetailsView m


view : Model -> Html Msg
view model =
    div [ class "flex flex-col w-full pt-3" ]
        [ div []
            [ div
                [ class "p-12 bg-gray-300" ]
                (List.map (mealCardView model) model.meals)
            , button
                [ onClick CreateMeal
                , class "p-4 m-4 border rounded-full hover:shadow-md"
                ]
                [ text "add meal" ]
            ]
        ]
