From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Fri, 21 Dec 2007 14:47:23 -0800
Message-ID: <20071221224722.GK29941@cornholio.qualcomm.com>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
	<1198236856.3488.11.camel@raven.themaw.net>
	<20071221192744.GA14860@cornholio.qualcomm.com>
	<20071221211259.GC29941@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071221211259.GC29941@cornholio.qualcomm.com>
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

On Fri, Dec 21, 2007 at 01:13:00PM -0800, Mike Marion wrote:

> Even weirder... I built a new box in our lab to use for testing and
> found that a small subset of paths didn't get loaded in the initial
> startup.. but when the default 10min timeout happened, they were then
> added.  That subset exactly matches the subset we're seeing the bug
> with.  Nothing obvious in verbose output as to why it didn't load those
> paths initially.

Well I have tracked down what appears to be the root cause.  The above
made me run a loop of ldapsearch queries against our ldap farm and I
found that periodically I would get a return missing the exact paths
we're seeing being removed then re-added over and over.  We have a CSS
setup to handle load balancing and failover for the ldap farm and I
found that one server behind it is giving out the broken maps.  Working
on getting that fixed ASAP (I'm not the ldap guy).

No details on why this happening over several hours would eventually get
the daemon into a state where it finally core-dumped though.  But fixing
the map results should make that not happen anymore anyway.  If I can
manage to catch a debug output and/or strace of one that still
core-dumps before the ldap side is fixed, I'll pass it along.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
"Do you know what this is?  No, I can see you don't.  You have that vacant look
in your eyes that says, 'Place my head to your ear.. you will hear the sea!'"
--Londo, Babylon 5.
