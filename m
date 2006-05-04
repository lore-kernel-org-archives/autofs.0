From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Umount call getting stuck, hanging nfs?
Date: Thu, 4 May 2006 15:07:08 -0700
Message-ID: <20060504220708.GQ27751@cornholio.qualcomm.com>
References: <20060504204141.GO27751@cornholio.qualcomm.com>
	<x49wtd1wkqi.fsf@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49wtd1wkqi.fsf@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, May 04, 2006 at 05:20:05PM -0400, Jeff Moyer wrote:

> Really sounds like an NFS problem.  I'd post to the NFS list, and they'll
> likely ask for over-the-wire messages.

I'll give that a shot.  Only problems are that once it's in this state,
the box never talks to the NFS server anymore when any stats or other
operations on the stuck path(s) are done, and it'd be hard to catch one
in the act of getting stuck.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
George: "You don't work in the rain?  You're a mailman...  Neither Rain, nor 
sleet, nor sno-IT'S THE FIRST ONE!" ==> Seinfeld
