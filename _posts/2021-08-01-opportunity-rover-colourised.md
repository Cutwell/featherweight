---
layout: post
title: Using neural networks to colourise images from the Opportunity Mars Rover.
categories: [Artificial Intelligence, Neural Networks, Python]
---

![figure 0](/images/2021-08-01-opportunity-rover-colourised/1.png "figure 0")

On February 13, 2019, NASA officials declared the Opportunity mission complete, and the Mars Rover dead, after its solar panels buried beneath a dust storm on June 12, 2018, and it failed to make contact for 9 months.

<!--more-->

To NASA, the mission was a resounding success, that had continued well past its original parameters. For the rest of us though, the death of Opportunity (affectionately known as "Oppy") was a tragedy, and the internet payed its respects to the small semi-autonomous rover, stranded an (average) 64 million kilometres from its home planet.

It was at this time that we discovered a database of images, collected by NASA rovers and made available to the public. The images taken by the cameras of the Opportunity rover formed a stop-motion journey of the rover's working life. By training a neural network on colour images of the mars surface and using this data to recolour the Opportunity greyscale images, we could produce a full set of colourised photographs.

At the time, we did not have the technical capabilities for such an undertaking, which is why (1.5 years on) and 2/3rds of a BSc in Computer Science completed, we returned to finish the original vision (*And then waited another 9 months to write this article..*).

This article is a primer on machine learning, and details the complete process of solving a problem using neural networks. We look at the basics of neural networks, how to express a problem in a format neural networks can understand, obtaining a dataset and normalising it, and utilising cloud computing to train and test a machine learning model.

---

# What is a neural network?
Neural networking was created as a way to understate the biology of the brain. Your brain is made up of a network of over 100 billion interconnected neurons, which interlink to form an advanced biological computer. 

## A biological neuron
![figure 1](/images/2021-08-01-opportunity-rover-colourised/2.png "figure 1")

Figure 1 describes a biological neuron or nerve cell. The nerve cell consists of several components - the synapses, which are lines of input from other cells, the dendrites, which collate the inputs from synapses into a combined signals, and the cell body, which can output its own signal when the total input signals meet a certain threshold. 

There are two kinds of synapses, excitatory and inhibitory. Excitatory synapses promote neurons to fire, making their inputs larger than their original signal, while inhibitory synapses demote the signals they carry, diminishing their impact on whether the neuron fires or not.

## A simple artificial neuron
![figure 2](/images/2021-08-01-opportunity-rover-colourised/3.png "figure 2")

Figure 2 describes a simple artificial neuron, which is the building block of a neural network. You can observe many parallels between artificial and biological neurons, from the use of weights to inhibit or promote an input, to an activation threshold, determining when the neuron should give an output. 

A single neuron will have multiple input neurons, either from the original input or from the previous layer in the network. Each input will be of different importance to the output of the neuron, represented by a weight, which could increase or decrease its value. The weight of an input is analogous to the the "excitatory" and "inhibitory" synapses in biological cells.

## A one-dimension network
![figure 3](/images/2021-08-01-opportunity-rover-colourised/4.png "figure 3")

The simplest neural network is a 1-dimensional network. In this network, inputs (in black) are directly mapped onto outputs (in white). 

A number of problems can be solved with this method, but it is is severely limited by its lack of complexity. For instance, it is unable to solve XOR problems.

## A two-dimension network
![figure 4](/images/2021-08-01-opportunity-rover-colourised/5.png "figure 4")

The 2-dimensional network is much more complex, and allows us to solve more complex problems.

In this network, inputs (in black) are mapped onto a series of 'hidden' neurons (in grey). In this example there is a single hidden layer, but there can be any number of layers in a full network, depending on the problem. 'Hidden' layers are so named because they aren't visible to the user. When using a neural network, the user sees the input and the output, and any intervening transformations are hidden. 'Hidden' can also refer to the transformation process itself, as a neural networks are not easily comprehensible, and the processes performed to transform an input to an output are often considered unexplainable.

By collecting multiple layers of neurons, a network becomes capable of "deep learning". This process allows the network to learn, either supervised or unsupervised, to solve complex problems such as classification or non-linear regression, in a manner similar to how the brain works.

## Further reading

We can recommend Kevin Gurney's "[An Introduction to Neural Networks](https://www.inf.ed.ac.uk/teaching/courses/nlu/assets/reading/Gurney_et_al.pdf)", UCL Press, 1999, as it is an excellent history of neural networks, and was used extensively for constructing the figures in this article. 

---
# Training a neural network.
Neural networks require a lot of data. There's generally no such thing as too much training data, as it gives the network more information to learn from. However, before generating the training dataset, we must properly understand the problem we are looking to solve.

Formally, what we're looking to achieve is to create a neural network which uses supervised learning to teach a network to identify non-linear relationships between colour images and greyscale images, based on the composition of the input and labelled output images, in order to predict colourised outputs from unlabelled input data. 

![figure 5](/images/2021-08-01-opportunity-rover-colourised/6.png "figure 5")

Colour images typically use 3 values per pixel; the Red, Green and Blue channels. Greyscale images, however, only use 1 value per pixel; the Grey/Light channel. 

![figure 6](/images/2021-08-01-opportunity-rover-colourised/7.png "figure 6")

For example, figure 6 shows how a colour image of a glacier can be divided into three channels of red, green and blue, which when combined produce the full image.

![figure 7](/images/2021-08-01-opportunity-rover-colourised/8.png "figure 7")

Further, figure 7 demonstrates how a full colour image compares to a grey-scaled version. Note how the colour is lost, but the light/dark balance of the image is retained.

What we are attempting to create is a network capable of accepting greyscale images as an input, and outputting accurately colourised images.

We could train our network to convert between greyscale and RGB directly, but another colour space exists that allows us to bridge the gap more easily. L.A.B. colour space works on the basis of three values: L (light balance), which is the same as our greyscale pixel values, and A and B values, which are used to indicate colour values using a scale of -128 -> 128.

There are several advantages to using L.A.B. colour space. Reducing the number of values the network must predict from three to two is advantageous, as it simplifies the problem significantly. As the final output will copy the light balance from the original input onto the output pixel, more detail is preserved, as shown in the example above, improving the legibility of the output and hiding any mistakes made by the network. Also, L.A.B. colour space can be converted formulaically into RGB colour space, or be presented on its own, presenting multiple options for displaying the output.

---
# Creating a training dataset

As mentioned before, NASA makes plenty of data available online, which we can access over API.

However, of the several thousand images downloaded, many were unusable. Some were unfocussed, or suffered from other blurring effects, while some were straight up empty files. In order to keep the dataset at a high quality, we had to filter this data somehow.

In order to identify blurred images, we calculated the laplacian variance of each image of the dataset, and removed any images that exceeded a threshold. A full list of normalisations performed where:

 * Removed greyscale images (as we cannot train a network from these). 
 * Removed blurry images (using laplacian variance). 
 * Removed empty image files (due to bad dataset, or network interruption during downloading). 
 * Cropped images to 1024x1024 shape. 

These normalisations ensured the network was only learning from perfect data, and by automating this process we were saved from manually accepting or rejecting several thousand photos by hand!

The full source code and workflow for this project is open-source and available on my [GitHub](https://github.com/Cutwell/opportunity-rover-colourised).

---

# Training a network

How do we translate our theoretical knowledge of a neural network into a functioning application? While we could spend time prototyping and optimising our own solution, this task has already been done by engineers at Google, and made available to the public in the form of the TensorFlow project.

TensorFlow is offered as a Python library, containing the majority of the code we need to train our neural network. Python is a popular programming language for machine learning development, as it is simple to program in (its commonly the first language taught to students), and its favoured by companies like Google, who are leading the development of machine learning and produce their tools in Python, encouraging the rest of the industry to follow suit.


Neural networks are trained in alternate steps. First, the full network is generated in a random state. Neural networks are initialised with random weights and values for each neuron, and the training process transforms this random state into precise data for generating data. 

Next, a cycle of steps begins. An input image (in greyscale) is passed through the network, and the output image (now in RGB) is compared to the original RGB image. An algorithm is then applied to calculate the differences (mistakes) between the two images, and the network is then adjusted from back to front, so it will generate a more accurate image next time. This process is repeated many thousands of times, for the full range of images in the dataset. This generates a network capable of colourising and matching a range of different images.

This generalisation is where the nature of our problem is well suited to machine learning. It is much simpler for a neural network to learn to generate data for a simpler set of data. As the main colours of our images are a mixture of dusty reds, browns and metallic greys, the network can learn to identify this simple set of colours from greyscale much easier than a more complex range of colours.

## Problems encountered.
When setting up our training program, we noticed an issue with our dataset. As we've explained, our dataset consists of 1024x1024 images, and the initial plan was to create layers in our network relating 1-to-1 neurons to pixels. However, this would require 1048576 neurons per layer, which would quickly exceed the RAM available on our machine.

We resolved instead to further split our training dataset images into slices of 64x64 pixels. This way, each layer in our network would only consist of 4096 neurons, which was far more attainable. This decision did come with compromise though, as it meant that the generated images would have to be processed in these 64x64 slices, meaning that in some cases the final product may lack cohesion - e.g.: the borders between stitched slices may be obvious, as the network would have no knowledge of the pixels bordering the edges of the slice, and so each slice may not smoothly transition.

# Exporting the project to a cloud platform.

As detailed in another of my articles, I have been writing this project entirely on a 2014 MacBook Air, which is not an especially powerful machine, and is not well suited to machine learning development.

Enter [FloydHub](https://www.floydhub.com/), a cloud computing platform designed specifically for machine learning and, would you guess it, TensorFlow. A few bonus points, in my opinion, was their free credit with the GitHub Student Developer Pack, their git-like command line interface, and access to GPU-accelerated processing. TensorFlow is able to utilise the GPU to process data faster, and this enabled us to train the model in a few hours, which is competitive for machine learning.

Side note: [FloydHub is shutting down](https://www.floydhub.com/shutdown). As of August 20th, 2021, the service will no longer be available. The platform was absolutely vital in enabling us to complete the project. It was encouraging to see an independent platform competing with cloud computing giants like Google and AWS, and it is a shame to see it go offline.

---

# Colourising the Opportunity Rover.

![figure 8](/images/2021-08-01-opportunity-rover-colourised/9.png "figure 8")

After a complete model was trained, all that remained was to test it upon the Opportunity Rover dataset and analyse the results. It was interesting to see in what areas the network excelled, and where it lacked.

When it came to painting the iconic reddish-brown colour of Mars, the network was spot on. However, either NASA's Rover has gotten dusty during its operation, or there simply wasn't enough pictures of the Rover itself for the network to learn about white plastic and metal grey.

This highlights an issue with our dataset. At a glance the issue is obvious, there is significantly more dirt and rock in the dataset than there is Rover images. This is a limitation of data source, as Opportunity wasn't sent to Mars to take selfies. In the future, we could correct this issue by either reducing the number of scenery photos, or training the dataset multiple times on the Rover images, to encourage the network to learn more about painting these colours.

<iframe width="560" height="315" src="https://www.youtube.com/embed/PYRlofDugBI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The video above is the final product of this project, the complete (useable) set of images recorded by the Opportunity Rover's front-left HazCam, rendered at 5 FPS. Some sections render better than others, and the Rover appears to teleport at times, when there are time gaps in the dataset, but overall the effect is incredibly pleasing.

---

# To conclude..

This project can be marked as successfully completed, as we have achieved our original goals satisfactorily. If we return to this project in the future, there are several avenues for improving the network and final product, including correcting the colouring of the Mars Rover, and experimenting with ways to expand vision of the machine, to produce more cohesive output.

# Extra notes.
There are couple of people to thank for providing the groundwork for this project. The first is [Psidex](https://github.com/psidex), who wrote the original code to extract the Opportunity images from the dataset, and the second is [Emil Wallner](https://github.com/emilwallner), who wrote an [article](https://emilwallner.medium.com/colorize-b-w-photos-with-a-100-line-neural-network-53d9b4449f8d) on using FloydHub and colouring greyscale images with neural networks. Both made this project a lot easier, and you should definitely check out their work.
