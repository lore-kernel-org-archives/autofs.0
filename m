From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Automatic reloading of file maps?
Date: Wed, 19 May 2004 17:36:57 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40ABFDA9.70106@sedona.intel.com>
References: <ufaekpgt5te.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufaekpgt5te.fsf@epithumia.math.uh.edu>
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
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

Jason L Tibbitts III wrote:

>Under older versions of autofs, changes in file maps are automatically
>picked up by the automount daemons.  I can just push out a new set of
>maps and they are used without tickling the daemons at all; the next
>time the filesystem is mounted, the new entry is used.  That doesn't
>seem to work now (under 4.1.2) and I'm wondering if this is expected
>behavior.
>  
>
This is a known issue with the 4.1.x version.  It came as a side effect 
of ghosting.

Take a look at the mailing list for roughly the last 4 weeks.  It has 
been a heavily discussed item.

Ian and others are working on a solution.

Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
