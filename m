From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs
Date: Fri, 16 Apr 2004 12:12:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404161210260.10506@wombat.indigo.net.au>
References: <20040415001726.M16653@ftghome.com>
	<Pine.LNX.4.58.0404152040580.15663@donald.themaw.net>
	<20040415152622.M43406@ftghome.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040415152622.M43406@ftghome.com>
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
To: Dinesh Parmar <dinesh@ftghome.com>
Cc: autofs@linux.kernel.org

On Thu, 15 Apr 2004, Dinesh Parmar wrote:

> Here is the requested information
> 
> I am able to get maps using ypcat -k auto.home & ypcat auto.xyz but not by
> auto_home & auto_xyz(gives error as server does not have these maps).
> 
> The kernel is Linux 2.4.18-3 version & autofs is 1.4.

You mean 4.1.0 yes.

> 
> The only thing which i tried was to specify the maps in auto.master,
> 
> more /etc/auto.master
> 
> home       auto.home    -nosuid,nodev
> xyz        auto.xyz     -nosuid.nodev

Where is the leading slash on these master map entries?

Ian
