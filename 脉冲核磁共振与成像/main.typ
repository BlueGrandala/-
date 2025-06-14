//#import ("@preview/meppp:0.2.1"): *
#import "/meppp-main/lib.typ": *


//#set text(font: "Source Serif Pro")
#let agl = [$angle.l$]
#let agr = [$angle.r$]
#let int = [$integral$]

#let abstract = [本次实验我们探究了脉冲核磁共振与核磁共振成像技术。我们观察了脉冲核磁共振的共振频率和自旋回波现象，使用了CPMG序列来测量不同浓度CuSO#sub[4]样品的横向弛豫时间$T_2$，并使用$pi-tau-pi/2$序列测量了纵向弛豫时间$T_1$。此后我们进行了不同形状样品的核磁共振成像，并探究了弛豫时间加权成像的技术。]
  

#show: doc => meppp-lab-report(
  title: "脉冲核磁共振与成像",
  author: "徐若涵",
  info: "物理学院 2100011868",
  abstract: abstract,
  keywords: (
    "脉冲核磁共振",
    "自旋回波",
    "CPMG序列",
    "核磁共振成像",
    "弛豫时间加权",
    "相位编码",
  ),
  author-footnote: [2100011868\@stu.pku.edu.cn],
  doc,
)

#set par(leading: 0.6em)

= 实验背景
核磁共振（NMR，Nuclear Magnetic Resonance）是一种基于原子核在磁场中与射频场相互作用的技术，其原理依赖于原子核自旋在特定频率下的共振吸收现象。共振频率和退激的时间尺度与
物质种类、结构和环境有关，故可利用核磁共振探测物质的结构。

核磁共振技术早期依赖连续波核磁共振波谱仪（CW-NMR），但其灵敏度低且耗时长。随着技术进步，脉冲傅里叶核磁共振仪（PFT-NMR）逐渐成为主流。脉冲核磁共振通过施加短时强射频脉冲激发原子核自旋系统，使大量原子核同时进入非平衡态，随后在弛豫过程中释放电磁信号。与传统连续波核磁共振（CW-NMR）相比，脉冲法通过傅里叶变换对接收的信号进行快速解析，不仅能高效获取频谱信息，还可精确测量横向弛豫时间（$T_2$）和纵向弛豫时间（$T_1$），从而显著提升检测灵敏度和时间效率。这一技术突破使得核磁共振从单纯的化学分析工具拓展至动态生物过程研究领域。

核磁共振成像（MRI，Magnetic Resonance Imaging）的实现则进一步结合了梯度磁场与空间编码技术。例如，1973年P.C. Lauterbur提出的投影重建法，利用梯度磁场对氢质子信号进行空间定位，首次实现了水分子分布的二维成像。此后，Peter Mansfield开发的快速平面成像技术大幅缩短扫描时间，使得人体器官与组织的实时可视化成为可能。在医学应用中，不同组织的$T_1$和$T_2$差异成为图像对比度的来源。例如，肿瘤因含水量高导致$T_2$弛豫时间延长，在$T_2$加权成像中呈现高信号，从而为疾病诊断提供依据。

本实验即利用脉冲核磁共振仪器，测定了不同浓度CuSO#sub[4]溶液的弛豫时间（$T_1$和$T_2$）.并进一步探究了结合梯度磁场进行空间编码，对几种不同样品实现了$T_2$加权的样品成像。

= 实验原理
== 脉冲核磁共振
量子力学的一个经典结果是一个具有磁矩的原子核在外加静磁场*$B_0$*中会发生*Lamor进动*，其频率为*Lamor频率*：
$
omega_0 = gamma B_0
$
其中$gamma$是核的旋磁比，$B_0$是外加静磁场的强度。这时如果在静磁场之外施加一个射频脉冲$B_1（t）$，其频率$omega$接近Lamor频率，则核自旋会发生共振吸收（费米黄金定则），进而使得核自旋的取向发生翻转。这个问题可以由基于经典力学的半唯象的Bloch方程描述。不过，对于单个1/2自旋，其实可以直接用量子力学来描述（Rabi共振）：考虑一个初始处于平衡（自旋朝向上）的态，严格求解薛定谔方程，得到翻转概率的Rabi解，
$ P(t) = omega_r^2 (sin^2(sqrt(omega_r^2+delta omega^2)t/2))/(omega_r^2+delta omega^2) $

其中$omega_r=gamma B_1$为*Rabi频率*，失谐频率$delta omega=omega-omega_0$。容易发现当射频场频率等于Lamor频率时，翻转概率最大，此时翻转频率就是$omega_r$。这样，我们可以通过调节射频脉冲的强度和持续时间来控制核自旋翻转的角度（$theta =omega_r tau= gamma B_1 tau$），这就是PFT-NMR的核心原理。

原子核在进动的同时，还会因为与环境相互作用导致发生*弛豫*，会缓慢地回到平衡态。弛豫的过程分为两种：纵向弛豫和横向弛豫。纵向弛豫是指核自旋在$z$轴方向上恢复到平衡态的过程，横向弛豫是指核自旋在$x-y$平面上恢复到平衡态的过程。纵向弛豫时间$T_1$和横向弛豫时间$T_2$分别定义为弛豫过程的时间常数。$T_1$和$T_2$的物理意义是核自旋在平衡态附近的涨落时间尺度，其大小与物质的性质有关。
$T_1$和$T_2$的测量方法有很多种，例如可以直接观测其自由感应衰减信号（free inductive decay,
 FID）来获取。
 
 实际测量$T_2$最常用的方法是自旋回波（spin echo，SE）技术和CPMG脉冲序列等。SE技术的原理是利用$pi/2-tau-pi$脉冲序列，先将自旋翻转到$x-y$平面上，然后等待时间$tau$，在此期间自旋会因为局部磁场的不同而发生相位差，导致信号衰减。然后施加一个$pi$脉冲，将自旋翻转到$-x-y$平面上，此时自旋的相位差会被反转，从而在$tau$时刻重新聚焦，产生一个回波信号。这个回波信号的强度与横向弛豫时间$T_2$有关。CPMG脉冲序列则是将SE技术进行多次重复，形成一个脉冲序列，可以更好地测量$T_2$。

#figure(image(".\img\\SEp.png",width: 60%), caption: [SE测量$T_2$原理示意图])<sep>
#figure(image(".\img\\CPMGp.png",width: 70%), caption: [CPMG序列测量$T_2$原理示意图])<cpmgp>

测量$T_1$的常用方法是$pi-tau-pi/2$的反转回复（inversion recovery，IR）脉冲序列。该序列的原理是先施加一个$pi$脉冲将自旋翻转到$-z$方向，然后等待时间$tau$，在此期间自旋会因为局部磁场的不同而发生相位差，导致信号衰减。然后施加一个$pi/2$脉冲，将自旋翻转到$x-y$平面上，读取得到此时的信号。通过调节$tau$的时间，可以得到不同$tau$下的信号强度，从而拟合出$T_1$的值。



== 核磁共振成像

核磁共振成像的基本原理是通过施加梯度磁场和射频脉冲，对样品中的核自旋进行空间编码，从而获得样品的空间分布信息。MRI的成像过程可以分为以下几个步骤：

1. $z$方向通过施加梯度场$B_z (z)$对样品进行空间编码，使得不同位置的核自旋具有不同的Lamor频率。这样，在施加$pi/2$射频脉冲时，只有特定$z$处的核自旋会发生共振吸收，产生信号，从而实现了$z$方向选层效果。完成后撤去梯度场和射频脉冲。

2. $y$方向通过梯度场实现相位编码。施加$pi/2$射频脉冲后，选中的层中的核磁矩处于$x-y$平面上，此时再施加一个y方向不均匀的梯度场$B_z (y)=y*G_y$，持续时间$t_y$，由于进动速度$omega_y =gamma B_z (y)$不同，会使得不同$y$位置的核自旋具有不同的相位差$Phi_y=exp(i omega_y t_y)$。通过多次调节不同的$B_y$，可以获得y方向的空间编码信息。

3. 再施加$x$方向不均匀的梯度场$B_z (x)=x*G_x$，持续时间$t_x$，直接测量$M_(x y)$信号。由于不同位置的核自旋具有不同的Lamor频率$omega_x =gamma B_z (x)$，因此可以通过傅里叶变换将信号转换为空间分布信息。

考虑弛豫过程，最终得到的信号为$ S(t_x,t_y)=int d x d y e^(i (omega_x t_x+omega_y t_y))rho(x,y)e^(-t/T_2) $
对它做傅里叶变换，就得到$T_2$加权的$rho(x,y)$成像。

= 实验内容与结果分析
本实验使用的核磁仪器为自动化程度较高的EDUMR20-015V-I核磁共振实验仪。由于本实验中的磁体对温度极为敏感，实验前需要开机预热90 min，直到磁体温度稳定到32℃左右，波动小于0.01℃。此后开启仪器进行数据采集。
== 采集FID信号
使用的样品为CuSO#sub[4]溶液，浓度为0.5%。将样品放入仪器，按照操作手册进行调节，测得中心频率$f_0=633789.04 H z$.扫描得到$pi/2$脉冲宽度为$P_1=19 mu s$,$pi$脉冲宽度为$P_2=38 mu s$.在此参数下测得的FID信号如下：
#figure(image(".\img\\FID.jpg",width: 60%), caption: [FID信号])<fid>
由于没有震荡行为，可知中心频率比较准确。

== 观察自旋回波现象
使用$pi/2-tau-pi$脉冲序列，调节$2tau=10 m s$，测得回波信号如下：
#figure(image(".\img\\SE2.jpg",width: 60%), caption: [自旋回波信号])<se>
可以看到回波信号虽然有明显衰减，但是还是比FID信号强得多。这是因为$T_2>T_2^*$.接下来，我们利用CPMG序列来测量不同样品的$T_2$.
== 利用CPMG序列测量$T_2$
这里使用的样品为不同浓度的CuSO#sub[4]溶液，浓度分别为0.5%、1%、2%。使用CPMG序列，调节回波间隔(采用$tau=2.2 m s$)和等待时间使得波形较好，无毛刺.测得不同浓度下的回波峰值信号如下：
#figure(image(".\img\\nolog.png",width: 60%), caption: [不同浓度下的CPMG信号])<cpmg1>
可见随着浓度增加，信号衰减速度增加。我们假设信号衰减符合指数衰减规律$S(t)=S_0 e^(-t/T_2)$，因此采取对数作图，并采取线性拟合(由于衰减后期非常接近0而误差较大，故拟合时只取了前20个数据点，不考虑后期数据)，得到不同浓度下的$T_2$值，结果如@1 和@cpmg2 所示。由拟合结果可知，数据呈现非常良好的线性关系，这说明指数衰减的模型比较符合实际。此外，浓度越大，$T_2$值越小，这与我们预期一致。进一步地，浓度增加一倍时弛豫时间近似缩短一半。

这个结果可以这样理解：横向弛豫过程本质上是一种退相干过程，弛豫时间依赖于核自旋与环境作用的强度，浓度增加意味着顺磁性离子增多，分子间的相互作用增强，从而加速了横向弛豫的过程。
#meppp-tl-table(
  caption: [使用CPMG信号拟合求$T_2$],
  table(
    
    columns: 5,
    rows: 4,
    table.header([浓度],[斜率/$m s^(-1)$],[截距],[$T_2$/$m s$],[$r$ value]),
    [0.5%], [-0.019995], [7.269114], [50.0115],[-0.999985],
    [1%], [-0.041299], [7.287192], [24.2133],[ -0.999990],
    [2%], [-0.079819], [7.376999], [12.5281],[-0.999990],
  ),
)<1>
#figure(image(".\img\\cpmg-fit.png",width: 60%), caption: [不同浓度下的CPMG信号对数作图及线性拟合])<cpmg2>

== 利用IR序列测量$T_1$

使用$pi-tau-pi/2$的IR脉冲序列，调节$tau$, 类似地读取信号如下图所示：
#figure(image(".\img\\IR.png",width: 60%), caption: [不同浓度下的IR信号])<ir>
这里可以发现不同浓度的平衡极化量略有不同，可能是由于Cu#super[2+]的磁矩耦合引起的。所以这里的数据处理应该为：取每一组数据的最大值（加上一个小量以防止数值溢出）作为平衡极化，然后扣除平衡极化后取对数作图，并作线性拟合(和上面一样，这里只取了前20组数据拟合)：
#figure(image(".\img\\t1.png",width: 60%), caption: [不同浓度下的IR信号对数作图及线性拟合])<ir2>
#meppp-tl-table(
  caption: [使用IR信号拟合求$T_1$],
  table(
    
    columns: 5,
    rows: 4,
    table.header([浓度],[斜率/$m s^(-1)$],[截距],[$T_1$/$m s$],[$r$ value]),
    [0.5%], [-0.019691], [50.7845], [8.6027],[-0.9984],
    [1%], [-0.037730], [26.5038], [8.5673],[ -0.9992],
    [2%], [-0.069911], [14.3037], [8.6665],[-0.9998],
  ),
)<2>
从测量结果可以看到，$T_1$的大小同样随着浓度增大而减小，与$T_2$类似。此外，$T_1$总是大于$T_2$, 这是显然合理的，因为总角动量要求$M_z=M_0$时必须有$M_(x y)=0$，但另一方面$x-y$平面的自旋如果相位失配可以有$M_z != M_0$但$M_(x y)=0$的情况出现，所以$T_2$的弛豫时间应该小于$T_1$的弛豫时间。

== 核磁共振成像
这里使用自旋回波法对0.5%CuSO#sub[4]溶液进行成像。按照软件说明书的指示，先进行Prescan，再用Scout粗扫描，软件能够自动校准中心频率，其余参数保持默认。完成后，将样品中插入三角形和六边形有机玻璃棱柱成像。需要注意的是，如果样品弛豫时间较短，可能会导致图像信噪比很低，这时需要适当增加采样平均次数（默认为6次），但是采样时间也会大大增加，因此必须做一个权衡。

#figure(
caption:[不同样品的MRI成像：
(a)0.5%CuSO#sub[4]溶液，(b)插入三角形有机玻璃棱柱，(c)插入六边形棱柱],
grid(columns:3,
  rows:1,
  subfigure(image(".\img\\sampling.1.jpg")),
  subfigure(image(".\img\\sampling.2.jpg")),
  subfigure(image(".\img\\sampling.3.jpg")),

)

)<MRI>

@MRI 展示了这几种样品的成像结果。由于有机玻璃为固体，其核自旋弛豫时间较短，因此在图像上显示为黑色，这是一种$T_2$加权效果。可以看到，三角形和六边形都有清晰的边角，说明成像的空间分辨率较为良好。此外，图片的信噪比尚可接受，说明取6次平均的做法是合理的。

接下来，我们通过同时对不同浓度的样品成像来更清楚地展示$T_2$加权成像的效果。我们将装有0.5%CuSO#sub[4]的小试管分别插入含有1%和2%CuSO#sub[4]的试管中，进行成像。由于不同浓度的样品弛豫时间不同，因此在图像上显示的亮度也不同。我们可以通过调节成像参数来观察不同浓度样品的成像效果。为了获得充分的信噪比，对1%和2%CuSO#sub[4]的样品我们分别取了12次和24次平均。成像结果如下：
#figure(
caption:[不同浓度下的成像结果。 

(a)为0.5%溶液插入1%溶液，(b)为0.5%溶液插入2%溶液],
grid(
columns:2,
  subfigure(image(".\img\\sampling.4.jpg")),
  subfigure(image(".\img\\sampling.5.jpg")),
)

)
可以看到，装有0.5%CuSO#sub[4]的试管在图像上显示为亮色，而装有1%和2%CuSO#sub[4]的试管则显示为暗色（其中2%样品最暗）。这正是因为不同浓度的样品弛豫时间不同，导致它们在成像时的信号强度不同，从而实现了$T_2$加权成像。如果要通过普通的光学成像来观察这些样品（尤其是无色溶液），将会很难分辨出它们的浓度差异。而通过核磁共振成像，我们可以清晰地看到不同浓度样品的成像效果，这正是核磁共振成像技术的优势所在。

在这两张图中我们还可以看到一个亮斑，这应该是由于试管反射聚焦射频辐射，导致局部射频场强增加的原因。如果想要消除这个亮斑，理论上可以通过对齐并旋转两个试管来实现，但我们没有做详细的探究。

= 实验总结
本次实验我们探究了脉冲核磁共振与核磁共振成像技术。我们观察了脉冲核磁共振的共振频率和自旋回波现象，使用了CPMG序列来测量不同浓度CuSO#sub[4]样品的横向弛豫时间$T_2$，并使用IR序列测量了纵向弛豫时间$T_1$，探讨了两种弛豫时间的大小关系及其随浓度的变化。此后我们进行了不同形状样品的核磁共振成像，探究了成像的分辨率，并探究了弛豫时间加权成像的技术。

通过本次实验，我们对脉冲核磁共振的基本原理和应用有了更深入的理解。核磁共振成像技术能够在不损伤样品、无电离辐射的情况下，对其内部结构进行观察，且能获得一些普通光谱学难以获得的性质（如弛豫时间、化学位移等），的确是一种重要的工具。

= 思考题
== 装着样品的圆形试管的一维剖面图应该是什么样子的曲线？
理论上实空间$x-y$剖面应该是圆形均匀分布的。如果考虑其傅里叶变换$S(t_x,t_y)$，将会得到一个类似Airy disk的函数乘以一个指数衰减因子。
$ int_(r<r_0) d x d y exp(i(x gamma G_x t_x +y gamma G_y t_y))e^(-alpha t) prop (J_1(gamma r_0 sqrt( (G_x t_x)^2+ (G_y t_y)^2)))/(gamma r_0 sqrt( (G_x t_x)^2+ (G_y t_y)^2)) e(-alpha t)  $
==  实空间图像的空间分辨率由什么因素决定？
主要的影响因素：磁场梯度（影响空间编码的准确性），采样密度（影响傅里叶变换的数据点数量），弛豫时间（影响信号强度），成像时间（影响信号强度），样品的性质（影响弛豫时间和信号强度）。
==  如何实现被$T_2$ 加权的核密度 $rho(x,y,T_2)$？
实际上，我们实现的MRI已经是被$T_2$加权的成像了。我们可以通过调节成像参数来实现不同的$T_2$加权成像。例如，调节回波间隔和等待时间，可以改变成像的对比度和亮度，从而实现不同的$T_2$加权成像。