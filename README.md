# XZHWebImage
/**
*  返回imageUrl
*
*  @return imageUrl
*/
- (NSString *)imageURL;
/**
*  直接设置WebUrl
*
*  @param url WebUrl
*/
- (void)setImageWithURL:(NSString *)url;
/**
*  设置WebUrl,还设置placeholderImageName
*
*  @param url             WebUrl
*  @param placeholderName placeholderImageName
*/
- (void)setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderName;
