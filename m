From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 issues
Date: Thu, 09 Aug 2007 17:07:15 +0800
Message-ID: <1186650435.3195.28.camel@raven.themaw.net>
References: <FB0EFEA980A6A1469DC5EB5DAE0BC7B703666DB0@pgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <FB0EFEA980A6A1469DC5EB5DAE0BC7B703666DB0@pgsmsx413.gar.corp.intel.com>
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
To: "Khor, Boon Pin" <boon.pin.khor@intel.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-07-24 at 07:03 +0800, Khor, Boon Pin wrote:
> Hi all  ,
> 
>   I have experiencing some inconsistency problem in autofs4 ( SLES9 SP3
> , kernel is 2.6.5 ) ,  sometime the mount daemon just died unexpected ,
> causing some mount point can not be mounted ( when cd to that directory
> , it will have "no such file or directory ) , in fact , restart the
> autofs daemon will caused some other mount point to be failed . I am
> wondering , that is this problem the known issue in autofs4 ? if yes ,
> is there any plan to back port the autofs5 to 2.6.5 ? the patch is only
> available for 2.6.9 and above .

I had a go at this but 2.6.5 is even harder than 2.6.9.
I'll return to it later but it will take a while.

Ian
