From: Ian Kent <raven@themaw.net>
Subject: Re: RE : Autofs V4 under SLES9
Date: Fri, 25 Aug 2006 20:02:09 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608252001060.30744@raven.themaw.net>
References: <B634AEB29A2B1B4281B7206EC4333E0A010AA91E@kmsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <B634AEB29A2B1B4281B7206EC4333E0A010AA91E@kmsmsx411.gar.corp.intel.com>
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
To: "Low, Kok Leong" <kok.leong.low@intel.com>
Cc: autofs@linux.kernel.org

On Fri, 25 Aug 2006, Low, Kok Leong wrote:

> Hi :
> 
>  
> 
> I have some issue with setting up direct map under SLES9, as the
> automount daemon always will not read the direct map entry , though no
> error is shown.
> 
> I did some search thru web and some are saying v4 is not supporting
> direct map and will be fix under v5. Also , I saw there is an option
> DISABLE_DIRECT =1 option under /etc/sysconfig/autofs and  I did tried to
> change from 1 to 0, still direct map does not work but indirect does.

That should work but there is limited support for direct maps in v4.

What does your map look like?

Ian
