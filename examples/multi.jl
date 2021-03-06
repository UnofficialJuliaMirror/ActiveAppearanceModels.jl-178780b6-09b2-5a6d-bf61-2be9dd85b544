
using ActiveAppearanceModels
using PiecewiseAffineTransforms
using FaceDatasets

imgs = load_images(CootesDataset)
shapes = load_shapes(CootesDataset)
@time m = train(AAModel(), imgs, shapes)
for i=1:10
    try
        img_idx = rand(1:length(imgs))
        shape_idx = rand(1:length(imgs))        
        triplot(imgs[img_idx], shapes[shape_idx], m.wparams.trigs)
        @time fitted_shape, fitted_app = fit(m, imgs[img_idx], shapes[shape_idx], 30);
        triplot(imgs[img_idx], fitted_shape, m.wparams.trigs)
        println("Image #$img_idx; shape #$shape_idx")
        readline(STDIN)
    catch e
        if isa(e, BoundsError)
            println("Fitting diverged")
            readline(STDIN)
        else
            rethrow()
        end
    end
end
