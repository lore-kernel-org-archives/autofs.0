From: Ian Kent <raven@themaw.net>
Subject: Re: Automatic reloading of file maps?
Date: Thu, 20 May 2004 09:14:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405200907490.21689@wombat.indigo.net.au>
References: <ufaekpgt5te.fsf@epithumia.math.uh.edu>
	<40ABFDA9.70106@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40ABFDA9.70106@sedona.intel.com>
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
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org

On Wed, 19 May 2004, Michael Blandford wrote:

> >Under older versions of autofs, changes in file maps are automatically
> >picked up by the automount daemons.  I can just push out a new set of
> >maps and they are used without tickling the daemons at all; the next
> >time the filesystem is mounted, the new entry is used.  That doesn't
> >seem to work now (under 4.1.2) and I'm wondering if this is expected
> >behavior.
> >  
> >
> This is a known issue with the 4.1.x version.  It came as a side effect 
> of ghosting.
> 
> Take a look at the mailing list for roughly the last 4 weeks.  It has 
> been a heavily discussed item.
> 
> Ian and others are working on a solution.

Yes. I've been giving it some thought and reading over the recent posts. 
After haveing another read and think, I'll post a description of my 
recommended (read easyiest for me to implement) approach to this, 
hopefully tonight.

It's to be the first thing I implement for 4.1.4 (along with the other 
"first to implement" things on the list .... ).

Ian
