From: Ian Kent <raven@themaw.net>
Subject: Re: Limit on return string from program map
Date: Fri, 17 Dec 2004 14:23:33 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
References: <21502.1103178424@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <21502.1103178424@kao2.melbourne.sgi.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Owens <kaos@ocs.com.au>
Cc: autofs@linux.kernel.org

On Thu, 16 Dec 2004, Keith Owens wrote:

> Kernel 2.6.9, autofs v4 as a module, autofs-4.1.3-28 (FC3).  I added
> "/net /etc/auto.net" to /etc/auto.master and it works fine, up to a
> point.  ps shows
> 
> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
> 
> If the target server has a lot of mounted filesystems then automount
> will only mount the first few entries on the list.  Then it tries to
> run mount with invalid input.  It looks like there is a hard coded
> limit on the string that automount expects from a program map.  My
> virtual CD server has lots of CD images mounted over loopback, each
> with its own export entry, so the return string from auto.net is quite
> long.

The buffer size for map entries is 4096.

Ian
