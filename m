From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs problem (migration from sun to linux )
Date: Sun, 7 Mar 2004 19:21:50 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403071919420.5818@raven.themaw.net>
References: <20040307070723.6F01D21AF4D@ws5-6.us4.outblaze.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040307070723.6F01D21AF4D@ws5-6.us4.outblaze.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: surya <surya_prabhakar@linuxmail.org>
Cc: autofs@linux.kernel.org

On Sun, 7 Mar 2004, surya  wrote:

> Dear All ,
>           We are migrating from sun to linux . The problem faced is , all the mounted directories are shown  by default in sun . But in linux the directories are not shown until they are accessed . Is there a way wherein all the directories are shown by default in linux like sun .
> 

Try looking at 
http://www.kernel.org/pub/linux/daemons/autofs/v4/

You need the kernel module update also.

Ian
