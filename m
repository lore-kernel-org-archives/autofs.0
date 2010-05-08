From: Peter Bajurny <bajurny@cs.umn.edu>
Subject: autofs5 variable substitution
Date: Fri, 07 May 2010 23:00:03 -0500
Message-ID: <4BE4E1C3.8050708@cs.umn.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I apologize if this is the wrong place for this, but my Googling has 
come up empty and I find myself at a loss.

In our enviroment we do automounts based on the OSNAME and OSREL 
variables.  With autofs4 and the sun automounter we manually specify the 
values of OSNAME and OSREL in the init scripts.  In the autofs4 init.d 
script there is a line for 'localoptions' where I can set '-DOSNAME=name 
-DOSREL=rel'.  But I can't for the life of me figure out how to set this 
with an autofs5 init script.  The init script specifies a confdir and 
the autofs file there.  I tried adding 'OPTIONS="-DOSNAME=name 
-DOSREL=rel"' to that line, and the automountd process started with 
those correct flags, but then it wasn't able to mount anything from my 
automount maps.  I also tried using LOCALOPTIONS instead of OPTIONS and 
that didn't do anything.

So I'm stuck.  Is there documentation somewhere on the configuration 
options I can pass to the init script?  Is what I'm trying to do 
possible anymore with autofs5

Thanks for the help,
Peter Bajurny
University of Minnesota Computer Science
