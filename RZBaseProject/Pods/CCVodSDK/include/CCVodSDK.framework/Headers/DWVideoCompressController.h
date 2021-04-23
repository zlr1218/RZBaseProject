#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @brief 媒体压缩质量
 */
typedef NS_ENUM(NSInteger, DWUIImagePickerControllerQualityType) {
    DWUIImagePickerControllerQualityTypeHigh   = 0,     // 高
    DWUIImagePickerControllerQualityTypeMedium = 1,     // 中
    DWUIImagePickerControllerQualityTypeLow    = 2      // 低
};

/**
 *  @brief 媒体来源
 */
typedef NS_ENUM(NSInteger, DWUIImagePickerControllerSourceType) {
    DWUIImagePickerControllerSourceTypePhotoLibrary,    //所有媒体
    DWUIImagePickerControllerSourceTypeCamera,          //摄像头
    DWUIImagePickerControllerSourceTypeSavedPhotosAlbum //仅相册
};

/**
 *  @brief 媒体类型：图片或视频
 */
typedef NS_ENUM(NSInteger, DWUIImagePickerControllerMediaType) {
    DWUIImagePickerControllerMediaTypeMovieAndImage,    //视频和图片
    DWUIImagePickerControllerMediaTypeMovie,            //视频
    DWUIImagePickerControllerMediaTypeImage             //图片
};

@interface DWVideoCompressController : UIImagePickerController

/*!
 * @method
 * @abstract 初始化对象
 * @discussion 初始化对象
 * @param videoQuality 媒体质量：高，中，低
 * @param sourceType 媒体来源：所有媒体，摄像头，仅相册
 * @param mediaType 媒体类型：图片或视频
 * @result DWVideoCompressController对象
 */
-(instancetype)initWithQuality:(DWUIImagePickerControllerQualityType)videoQuality
       andSourceType:(DWUIImagePickerControllerSourceType)sourceType
        andMediaType:(DWUIImagePickerControllerMediaType)mediaType;
@end

NS_ASSUME_NONNULL_END
