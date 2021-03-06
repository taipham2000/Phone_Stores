USE [PRJ301_Assignment_Group#3]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[categoryID] [nvarchar](10) NOT NULL,
	[categoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[orderDetailID] [int] NOT NULL,
	[orderID] [int] NOT NULL,
	[productID] [nvarchar](10) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[orderID] [int] NOT NULL,
	[userID] [nvarchar](10) NULL,
	[date] [date] NOT NULL,
	[total] [float] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[productID] [nvarchar](10) NOT NULL,
	[productName] [nvarchar](50) NULL,
	[price] [decimal](18, 0) NULL,
	[quantity] [int] NULL,
	[shortDescription] [nvarchar](500) NULL,
	[productDescription] [nvarchar](100) NULL,
	[imageUrl] [nvarchar](100) NULL,
	[categoryID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[roleID] [int] NOT NULL,
	[roleName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/22/2021 8:43:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [nvarchar](10) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[roleID] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categories] ([categoryID], [categoryName]) VALUES (N'AP', N'APPLE')
INSERT [dbo].[Categories] ([categoryID], [categoryName]) VALUES (N'OP', N'OPPO')
INSERT [dbo].[Categories] ([categoryID], [categoryName]) VALUES (N'SS', N'SAMSUNG')
INSERT [dbo].[Categories] ([categoryID], [categoryName]) VALUES (N'XM', N'XIAOMI')
GO
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (1, 1, N'XM04', 6990000, 2)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (2, 2, N'XM04', 32490000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (3, 3, N'XM04', 4490000, 2)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (4, 3, N'XM04', 32490000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (5, 4, N'XM04', 6690000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (6, 4, N'XM04', 21000000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (7, 4, N'XM04', 11490000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (8, 5, N'XM04', 29990000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (9, 5, N'XM04', 18290000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (10, 6, N'XM04', 26990000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (11, 7, N'XM04', 22990000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (12, 8, N'XM04', 8690000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (13, 9, N'XM04', 51000000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (14, 10, N'XM04', 7490000, 2)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (15, 11, N'XM04', 29990000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (16, 12, N'XM04', 6990000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (17, 13, N'XM04', 11490000, 1)
INSERT [dbo].[OrderDetail] ([orderDetailID], [orderID], [productID], [price], [quantity]) VALUES (18, 14, N'AP01', 33490000, 1)
GO
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (1, N'U04', CAST(N'2021-01-01' AS Date), 13980000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (2, N'U05', CAST(N'2021-01-04' AS Date), 32490000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (3, N'U06', CAST(N'2021-01-06' AS Date), 41470000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (4, N'U07', CAST(N'2021-01-10' AS Date), 39180000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (5, N'U08', CAST(N'2021-01-12' AS Date), 48280000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (6, N'U09', CAST(N'2021-01-20' AS Date), 26990000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (7, N'U10', CAST(N'2021-01-21' AS Date), 22990000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (8, N'U11', CAST(N'2021-02-14' AS Date), 8690000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (9, N'U12', CAST(N'2021-02-19' AS Date), 51000000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (10, N'U13', CAST(N'2021-02-20' AS Date), 14980000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (11, N'U14', CAST(N'2021-02-24' AS Date), 29990000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (12, N'U15', CAST(N'2021-02-24' AS Date), 6990000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (13, N'U16', CAST(N'2021-02-25' AS Date), 11490000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (14, N'U04', CAST(N'2021-06-22' AS Date), 33490000)
INSERT [dbo].[Orders] ([orderID], [userID], [date], [total]) VALUES (15, N'U04', CAST(N'2021-06-22' AS Date), 66980000)
GO
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'AP01', N'Điện thoại iPhone 12 Pro 256GB', CAST(33490000 AS Decimal(18, 0)), 1, N'Giống iPhone 5 nhưng phóng to với màn hình tràn viền. Màn hình OLED sắc nét, bền bỉ với vật liệu gốm Ceramic cao cấp. Kết nối 5G tốc độ nhanh ấn tượng', N'AP01.txt', N'iphone-12-pro-xam-new-600x600-600x600.jpg', N'AP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'AP02', N'Điện thoại iPhone 12 128GB', CAST(24490000 AS Decimal(18, 0)), 12, N'Hiệu năng vượt trội, thách thức mọi giới hạn. Vẻ đẹp gợi nhớ và chuẩn màn hình OLED. Hệ thống camera kép chuyên nghiệp. Công nghệ sạc đa năng', N'AP02.txt', N'iphone-12-trang-new-600x600-600x600.jpg', N'AP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'AP03', N'Điện thoại iPhone 11 256GB', CAST(21490000 AS Decimal(18, 0)), 28, N'Hiệu năng vẫn tương đương phiên bản Pro Max. Camera cải tiến lớn. Màu sắc mới, thiết kế đẹp hơn. Thời lượng pin đã tốt nay còn tốt hơn', N'AP03.txt', N'iphone-11-256gb-black-600x600.jpg', N'AP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'AP04', N'Điện thoại iPhone SE 256GB (2020)', CAST(16990000 AS Decimal(18, 0)), 6, N'Gọn nhẹ chắc chắn thoải mái sử dụng. Cấu hình vô địch trong tầm giá. Một camera vẫn xóa phông mượt mà. Pin đủ dùng, hỗ trợ sạc nhanh', N'AP04.txt', N'iphone-se-128gb-2020-trang-600x600.jpg', N'AP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'OP01', N'Điện thoại OPPO Reno5', CAST(8690000 AS Decimal(18, 0)), 17, N'Thiết kế đẹp đậm chất OPPO Reno Series. Bức phá hiệu năng với vi xử lý Snapdragon 720G mới. Màn hình lớn chuyển động 90 Hz mượt mà', N'OP01.txt', N'oppo-reno5-trang-600x600-1-600x600.jpg', N'OP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'OP02', N'Điện thoại OPPO Reno3 Pro', CAST(7990000 AS Decimal(18, 0)), 7, N'Màn hình Sunlight Super AMOLED cao cấp. Camera chất lượng hàng đầu. Pin dùng cả ngày, sạc siêu nhanh VOOC', N'OP02.txt', N'oppo-reno3-pro-den-new-600x600-600x600.jpg', N'OP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'OP03', N'Điện thoại OPPO Reno5 5G', CAST(11990000 AS Decimal(18, 0)), 5, N'Từng đường nét lấp lánh, tỏa sáng. Đem đến sự chân thật trong từng khung hình. Reno5 5G chiêu mộ mọi tính đồ chụp ảnh, checkin hay blogger', N'OP03.txt', N'oppo-reno5-5g-thumb-600x600.jpg', N'OP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'OP04', N'Điện thoại OPPO A93', CAST(6490000 AS Decimal(18, 0)), 3, N'Hiệu năng vượt trội cùng với Helio P95. Cụm camera selfie tích hợp AI. Thiết kế cảm hứng, khơi nguồn sáng tạo. Màn hình sống động, sắc nét', N'OP04.txt', N'oppo-a93-trang-14-600x600.jpg', N'OP')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'SS01', N'Điện thoại Samsung Galaxy S21 Ultra 5G 128GB', CAST(30990000 AS Decimal(18, 0)), 23, N'Đột phá trong thiết kế thời thượng. Thỏa mãn thị giác hơn bao giờ hết. Sức mạnh kinh khủng từ chip Exynos 2100. Sẵn sàng khám phá thế giới với camera đẳng cấp', N'SS01.txt', N'samsung-galaxy-s21-ultra-bac-600x600-1-600x600.jpg', N'SS')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'SS02', N'Điện thoại Samsung Galaxy A32', CAST(6690000 AS Decimal(18, 0)), 58, N'Thiết kế thời thượng cùng màu sắc bắt mắt. Màn hình giải trí sắc nét, đa chức năng. Bộ bốn camera sau đến 64 MP thỏa sức sáng tạo', N'SS02.txt', N'samsung-galaxy-a32-4g-thumb-xanh-600x600-600x600.jpg', N'SS')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'SS03', N'Điện thoại Samsung Galaxy Z Fold2 5G', CAST(50000000 AS Decimal(18, 0)), 10, N'Thiết kế cải tiến hướng đến sự hoàn thiện. Màn hình lớn và bền hơn thế hệ cũ. Bộ 5 camera kiến tạo tuyệt tác. Hiệu năng dẫn đầu với Snapdragon 865+', N'SS03.txt', N'samsung-galaxy-z-fold-2-vang-dong-600x600.jpg', N'SS')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'SS04', N'Điện thoại Samsung Galaxy Note 20 Ultra 5G Trắng', CAST(29990000 AS Decimal(18, 0)), 23, N'Thiết kế đẳng cấp xứng tầm siêu phẩm. Màn hình “không viền” vượt mọi giới hạn. S Pen thông minh đầy đủ tính năng đáng giá', N'SS04.txt', N'samsunggalaxynote20ultratrangnew-600x600-600x600.jpg', N'SS')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'XM01', N'Điện thoại Xiaomi Redmi 9T (6GB/128GB)', CAST(4690000 AS Decimal(18, 0)), 11, N'Trẻ trung với màu sắc nổi bật. Màn hình siêu lớn, trải nghiệm hoàn hảo. Chip “Rồng” 662 tốc độ nhanh, ổn định trong tầm giá', N'XM01.txt', N'xiaomi-redmi-9t-6gb-110621-080650-600x600.jpg', N'XM')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'XM02', N'Điện thoại Xiaomi Mi 11 5G', CAST(21990000 AS Decimal(18, 0)), 22, N'Thiết kế nổi bật với cụm camera độc nhất. Làm chủ mọi khung hình với bộ 3 camera 108 MP. Hiệu năng hàng khủng với Snapdragon 888', N'XM02.txt', N'xiaomi-mi-11-xanhduong-600x600-600x600.jpg', N'XM')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'XM03', N'Điện thoại Xiaomi Mi 10T Pro 5G', CAST(12990000 AS Decimal(18, 0)), 12, N'Mượt mà trong từng khung hình với tần số quét 144 Hz. Chơi game cực “mướt” với Snapdragon 865. Camera 108 MP sắc nét, thoả thích thu phóng', N'XM03.txt', N'xiaomi-mi-10t-pro-den-600x600.jpg', N'XM')
INSERT [dbo].[Products] ([productID], [productName], [price], [quantity], [shortDescription], [productDescription], [imageUrl], [categoryID]) VALUES (N'XM04', N'Xiaomi Redmi Note 9 Pro 6GB-128GB', CAST(6990000 AS Decimal(18, 0)), 23, N'Thiết kế bóng bẩy, cao cấp. Cấu hình mạnh mẽ với chip rồng Snapdragon. Cụm bốn camera 64 MP ấn tượng. Dung lượng pin khủng 5020 mAh', N'XM04.txt', N'xiaomi-redmi-note-9-pro-white.jpg', N'XM')
GO
INSERT [dbo].[Roles] ([roleID], [roleName]) VALUES (1, N'admin')
INSERT [dbo].[Roles] ([roleID], [roleName]) VALUES (2, N'user')
GO
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U01', N'Vinh', N'123', N'TP.HCM', N'0878989189', 1)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U02', N'Tram', N'123', N'TP.HCM', N'0877833033', 1)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U03', N'Tai', N'123', N'TP.HCM', N'0877598298', 1)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U04', N'Quyen', N'Quyen123', N'Quang Ninh', N'0929877477', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U05', N'Phuc', N'Phuc123', N'Ha Noi', N'0929608555', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U06', N'Linh', N'Linh123', N'Hai Duong', N'0929643777', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U07', N'Hoan', N'Hoan123', N'Cam Giang', N'0929855055', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U08', N'Uan', N'Uan123', N'Kinh Mon', N'0843556600', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U09', N'Do', N'Do123', N'Ha Noi', N'0879520999', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U10', N'Canh', N'Canh123', N'Ha Noi', N'0877263789', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U11', N'Tuan', N'Tuan123', N'Hai Duong', N'0929799599', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U12', N'Toan', N'Toan123', N'Hai Duong', N'0846333342', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U13', N'Ly', N'Ly123', N'Ha Noi', N'0927041777', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U14', N'Trung', N'Trung123', N'Ha Noi', N'0879194555', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U15', N'Loi', N'Loi123', N'TP.HCM', N'0919300444', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U16', N'Thanh', N'Thanh123', N'TP.HCM', N'0877769269', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U20', N'123', N'taipham', N'Binh Hung Hoa', N'0898121579', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U21', N'123', N'12547896', N'Binh Hung Hoa', N'0121547896', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U51', N'tainam', N'14587255', N'dfg', N'0125425187', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U5491', N'Quyen', N'12345678', N'kjn', N'0214578965', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U7901', N'Quyen', N'12301245', N'kjhn', N'0232121111', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U791', N'Quyen', N'15422222', N'khjn', N'0210000000', 2)
INSERT [dbo].[Users] ([userID], [userName], [password], [address], [phone], [roleID]) VALUES (N'U831', N'namqu', N'14587269', N'Ã¡ccÃ', N'0125478965', 2)
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([orderID])
REFERENCES [dbo].[Orders] ([orderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Products] FOREIGN KEY([productID])
REFERENCES [dbo].[Products] ([productID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([userID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Categories] ([categoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([roleID])
REFERENCES [dbo].[Roles] ([roleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
