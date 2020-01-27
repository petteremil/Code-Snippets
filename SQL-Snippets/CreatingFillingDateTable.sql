--Creating the actual table

CREATE TABLE [SCHEMA].[Calendar_Table](
	[Day] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[year] [int] NOT NULL,
	[Day_Name] [nvarchar](32) NOT NULL,
	[Month_Name] [nvarchar](32) NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Calendar_Table_1] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Filling the table with dates
DECLARE @StartDate Date
DECLARE @EndDate Date
SET @StartDate = Cast('2019-01-01' As Date)
SET @EndDate = Cast('2026-01-01' As Date)
DECLARE @Calendar TABLE
([Day] Int, 
 [DayName] Nvarchar(30), 
 [Month] Int, 
 [MonthName] Nvarchar(30), 
 [Year] Int
)

--Looping over dates, adding a day every turn of the wheel
WHILE @StartDate < @EndDate
      BEGIN
             INSERT INTO [database].[Schema].[Calendar_Table]
             (
                   [Day], [Month], [Year], [Day_Name], [Month_Name], [Date]
             )
             SELECT
                   Day(@StartDate),
				   Month(@StartDate),
				   Year(@StartDate),
				   DateName(weekday,@StartDate),
				   DateName(Month,@StartDate),
				   @StartDate

             SET @StartDate = DATEADD(dd, 1, @StartDate) --Adding a day here
      END