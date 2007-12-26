From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] fs/autofs: Use time_before, time_before_eq, etc.
Date: Wed, 26 Dec 2007 09:48:35 -0800
Message-ID: <477293F3.60304@zytor.com>
References: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752029AbXLZRtO@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0712261621000.1185@pc-041.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Julia Lawall <julia@diku.dk>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The functions time_before, time_before_eq, time_after, and time_after_eq
> are more robust for comparing jiffies against other values.
> 

More robust, how?  You already almost introduced a bug here...

	-hpa
