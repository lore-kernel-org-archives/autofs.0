From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Sun, 23 Dec 2007 23:40:30 -0800
Message-ID: <20071224074029.GC2644@cornholio.qualcomm.com>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
	<1198236856.3488.11.camel@raven.themaw.net>
	<20071221192744.GA14860@cornholio.qualcomm.com>
	<20071221211259.GC29941@cornholio.qualcomm.com>
	<20071221224722.GK29941@cornholio.qualcomm.com>
	<1198311611.3114.63.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1198311611.3114.63.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

On Sat, Dec 22, 2007 at 05:20:11PM +0900, Ian Kent wrote:

> That's good news at least.
> Any info you manage to get will be appreciated.

Later this week (after holiday) I'm going to see if we can setup a box
that keeps alternating between 2 test ldap servers that reproduce what
we were seeing here... basically just remove some paths from one so that
each update keeps making it drop, then re-add the paths.  Will make sure
to turn on full debug logging and also likely will strace the daemon.
Hopefully we can re-create the crash and gather some good data on it.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Ned: "How do you do it Homer?  How do you silence that little voice that says
think?"
Homer: "You mean Lisa?"  ==> Simpsons
