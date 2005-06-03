From: Michael Marion <mmarion@qualcomm.com>
Subject: Re: Strange new /net behavior
Date: Fri, 3 Jun 2005 15:48:43 -0700 (PDT)
Message-ID: <200506032248.j53MmhFI029265@crowley.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On  3 Jun, Michael Marion wrote:

> Going to try some debugging options on both archs to look for differences.

ah.. oops.  Nevermind, found the cause.  Had lost track of my /etc/auto.net
scripts and accidentally put an older one in the new rpm.  It was confused by
the * in showmount, and caused it's output to cause the funky mounting on
hosts with only 1 (wide open) mount.

Fixed...

We even had a CM system here to update our config files like that, but it
looks at dates and my rpm was newer then the source file.. so it wasn't
getting overwritten.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
A nerd is someone whose life revolves around computers and technology.
A geek is someone whose life revolves around computers and technology... 
and likes it!  - Stolen from a /. post.
