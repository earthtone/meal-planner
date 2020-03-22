module Main exposing (main)

import Browser
import Html exposing (Html, a, button, div, form, h3, img, input, label, text)
import Html.Attributes exposing (alt, class, href, src, type_, value)
import Html.Events exposing (onInput, onSubmit)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Meal =
    { name : String
    , imageUrl : String
    , recipeUrl : String
    }


type alias Index =
    Int


type alias Model =
    { meals : List Meal
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


addMeal : Meal -> List Meal -> List Meal
addMeal meal meals =
    meals ++ [ meal ]


removeMeal : Index -> List Meal -> List Meal
removeMeal index meals =
    let
        before n =
            List.take n meals

        after n =
            List.drop (n + 1) meals
    in
    before index ++ after index


updateMeal : Index -> Meal -> List Meal -> List Meal
updateMeal index meal meals =
    let
        before n =
            List.take n meals

        after n =
            List.drop (n + 1) meals
    in
    before index ++ [ meal ] ++ after index


type Msg
    = AddMeal
    | SetMealName String
    | SetMealImageUrl String
    | SetMealRecipeUrl String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddMeal ->
            { model
                | meals =
                    addMeal
                        { name = model.mealNameInput
                        , imageUrl = model.mealImageUrlInput
                        , recipeUrl = model.mealRecipeUrlInput
                        }
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


addMealView : Model -> Html Msg
addMealView model =
    form [ onSubmit AddMeal, class "flex flex-col p-8 mx-auto border shadow-md" ]
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


mealView : Meal -> Html Msg
mealView meal =
    div [ class "p-8 mx-auto border shadow-md" ]
        [ img [ src meal.imageUrl, alt meal.name ] []
        , h3 [ class "text-2xl" ] [ text meal.name ]
        , a [ href meal.recipeUrl, class "underline hover:text-gray-700" ] [ text "Recipe" ]
        ]


view : Model -> Html Msg
view model =
    div [ class "flex justify-center w-full pt-3" ]
        ([ addMealView model ]
            ++ List.map mealView model.meals
        )
