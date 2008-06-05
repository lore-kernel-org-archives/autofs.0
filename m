From: Paul Smith <psmith@netezza.com>
Subject: Re: System hanging in /proc/mounts almost every
	night...	help!
Date: Thu, 05 Jun 2008 11:25:44 -0400
Message-ID: <1212679544.6879.37.camel@psmithub.netezza.com>
References: <1212521944.7156.93.camel@psmithub.netezza.com>
	<x49ve0picd3.fsf@segfault.boston.devel.redhat.com>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ve0picd3.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-06-04 at 09:00 -0400, Jeff Moyer wrote:
> My advice for further debugging is to enabled autofs debug logging
> (see http://people.redhat.com/jmoyer), and when hung, get the output
> from sysrq-t.

Oh for...

and of course it didn't hang last night, for the first time.  I do have
to say that I installed a new kernel from the Ubuntu repositories
yesterday, with some security etc. fixes.  I didn't see any changes in
that update related to autofs or mounts but you never know.

I'll keep testing and see if it recurs.
