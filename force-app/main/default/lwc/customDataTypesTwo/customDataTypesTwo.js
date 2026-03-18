import LightningDatatable from 'lightning/datatable';
import CustomPictureTemplate from './customPicture.html';

export default class CustomDataTypesTwo extends LightningDatatable {
    static customTypes={
        customPictureType:{
            template:CustomPictureTemplate,
            standardCellLayout:true,
            typeAttributes:['pictureURL']
    }
    }
}