From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: making the mountpoints visible all the time
Date: Sun, 16 Nov 2003 10:09:42 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB7BD66.3010502@zytor.com>
References: <Pine.LNX.4.44.0311170006200.12952-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0311170006200.12952-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, "Taylor, ForrestX" <forrestx.taylor@intel.com>, "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>

Ian Kent wrote:
> 
> But how do you know what the keys are?
> 
> In order to make mount points visible you need to know what they are. The 
> definition of a program map is that it produces map entries as output 
> given an input key.
> 

You need a new operation on a map -- enumerate.  Most, but not all map 
types support it.

In the case of a program map I would suggest implementing enumeration by 
passing no argument and expecting the enumerated list back.

	-hpa
