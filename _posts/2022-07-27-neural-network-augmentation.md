---
layout: post
title: Using a neural network to augment wind data.
categories: [Machine Learning, Python]
---

![](/images/2022-07-27-neural-network-augmentation/wind.png)

My current dissertation project focusses on genetic optimisation of offshore wind farm site locations. Part of this optimisation is to maximise the energy efficiency of the wind farm, by maximising the available potential wind energy within the site. As I was focussing on a search space just off the U.K. east coast, I needed to gather historic wind data that fit this area.

<!--more-->

An issue I encountered whilst researching datasets for this project was that the data was not available in the resolution required. I found that the US Physical Sciences Laboratory (USPSL) offered historic wind data, but at a global scale. In order to use this data, I needed to increase the resolution of the to fit the scale of my search space.

At a global scale, the data looked suitably expansive:

![](/images/2022-07-27-neural-network-augmentation/wind_world.png)

But when zoomed into our search space, the resolution was clearly insufficient:

![](/images/2022-07-27-neural-network-augmentation/wind_uk.png)

---

## Designing a neural network
Regression is a machine learning technique to predict new data based on known data. This can be predicting weather based on previous history, predicting stock-market futures based on previous performance, or increasing a dataset resolution based on lower resolution data.

Our data is well-suited to regression, as we can utilise large amounts of low-resolution data to train our model at a global scale, then zoom into a particular search space and generate a desired amount of predicted data.

I decided to use the TensorFlow framework for this problem. Our model will simply convert longitude / latitude coordinates into wind data for given coordinates. Although this transformation is simple, we will need the model to have sufficient layers to learn complex spatial relationships / patterns that can be observed in our dataset.

After experimentation with different numbers of layers and parameters, I settled on this 50k parameter sequential model, with 6 hidden layers:

```
Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
dense (Dense)                (None, 32)                96        
_________________________________________________________________
dense_1 (Dense)              (None, 64)                2112      
_________________________________________________________________
dense_2 (Dense)              (None, 128)               8320      
_________________________________________________________________
dense_3 (Dense)              (None, 256)               33024     
_________________________________________________________________
dense_4 (Dense)              (None, 32)                8224      
_________________________________________________________________
dense_5 (Dense)              (None, 16)                528       
_________________________________________________________________
dense_6 (Dense)              (None, 8)                 136       
_________________________________________________________________
dense_7 (Dense)              (None, 1)                 9         
=================================================================
Total params: 52,449
Trainable params: 52,449
Non-trainable params: 0
_________________________________________________________________
```

When asked to emulate the dataset, in order to test if spatial relationships were learnt during training, the model gave good performance:

| | |
|:---:|:---:|
| ![](/images/2022-07-27-neural-network-augmentation/wind_plot.png) | ![](/images/2022-07-27-neural-network-augmentation/wind_pred_plot.png) |
| Training dataset | Model prediction |

We then applied the model to predict wind data specifically for our search space, at the same resolution as our bathymetric data:

| | |
|:---:|:---:|
| ![](/images/2022-07-27-neural-network-augmentation/bathymetric.png) | ![](/images/2022-07-27-neural-network-augmentation/wind.png) |
| Bathymetric data | Wind data |
| ![](/images/2022-07-27-neural-network-augmentation/bathymetric_zoomed.png) | ![](/images/2022-07-27-neural-network-augmentation/wind_zoomed.png) |
| Zoomed Bathymetric data | Zoomed Wind data |

---

# Conclusions
Obtaining appropriate wind data was a vital goal for advancing my dissertation project, so I'm pleased to have achieved such strong results.

The next goal will be to implement this data into our genetic optimisation - a further optimisation I've already made has been to pre-process wind data for the search space, instead of dynamically generate data during optimisation. Speeding up solution evaluation enables us to increase our population size and generations, which lets us form more precise pareto fronts.
