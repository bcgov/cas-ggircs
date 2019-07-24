import React , { Component } from 'react'
import * as SurveyJSCreator from "survey-creator";
import "survey-creator/survey-creator.css";
import Header from '../components/Header'


class SurveyCreator extends Component {
    surveyCreator;
    componentDidMount() {
        let options = { showEmbededSurveyTab: true };
        this.surveyCreator = new SurveyJSCreator.SurveyCreator(
            "surveyCreatorContainer",
            options
        );
        this.surveyCreator.saveSurveyFunc = this.saveMySurvey;
    }
    render() {
        return (
            <React.Fragment>
                  <Header/>
                 <div id="surveyCreatorContainer" />
            </React.Fragment>
            );
    }
    saveMySurvey = () => {
        console.log(JSON.stringify(this.surveyCreator.text));
    };
}

export default SurveyCreator;