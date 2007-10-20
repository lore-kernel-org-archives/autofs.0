From: Greg Earle <earle@isolar.dyndns.org>
Subject: Re: ENOENT on first reference to an automounted file To:
	autofs@linux.kernel.org
Date: Fri, 19 Oct 2007 18:28:30 -0700
Message-ID: <6766EDC4-0232-4304-B753-64A2E4C2898E@isolar.dyndns.org>
References: <mailman.1.1192795201.25176.autofs@linux.kernel.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.1.1192795201.25176.autofs@linux.kernel.org>
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

On Oct 19, 2007, at 16:02 AM, Ian Kent <raven@themaw.net> wrote:

> On Thu, 2007-10-18 at 03:36 -0700, Greg Earle wrote:
>> I am getting the impression from the bug reports (and posts in
>> this thread) that this bug is *not* fixed in 2.6.9-55.0.9; and might
>> not be until some point in the future when 2.6.9-61 is available via
>> "up2date".  Am I correct in that assumption?
>>
>> If so, we may have little choice but to rollback to Update 4 by
>> doing complete reinstalls from scratch (groan).  Is there any
>> info on when this bug first crept in, and is Update 4 - with
>> autofs-4.1.3-187 - safe to roll back to?  The natives are restless,
>> and they've already shown up outside my office door with torches
>> and pitchforks.  I've got a lot of unhappy Flight Projects reps
>> on my hands.  We need to make a command decision here Real Soon Now.
>>
>> Any illumination much appreciated.
>
> Well, if we can't confirm the problem and resolution then I have no  
> case
> to put for an update.

I can provide you (off-line, as it has potentially sensitive host
information) an overly-wordy e-mail I sent out to others in my
organization about the problem, illustrated with "strace" output
and "tshark" packet traces if you like.

I do have an update for you, though.  And it's very bizarre.

In Dan's original report to this list, he mentions having
turned *off* "--ghost" with his maps sourced from LDAP.

We use NIS for our maps, but just for fun, I decided to test
turning "--ghost" *on* (we default to it off, and we also use
"-nobrowse" on our Suns, so we like to keep them consistent),
and ...

It cured the problem!  So for now, we are using that as a
temporary kludge/workaround.

My tests, which could trigger it anywhere between as little as
4 1/2 minutes to (at most) 15 minutes, now run for an entire day
without error.

Another twist: in our "/home" map, we have about 127 individual
entries, but most of those are for people outside of our
particular organization with non-wildcard-able home directory
paths.  But for the rest of us, we *do* use a single wildcard "*"
entry:

*	rhel4u5server:/export/home/&

Using "--ghost" has, as expected, produced 127 phantom directories
under "/home" after a fresh reboot of the test system with it
enabled.  But here is what's of interest to me - the test script
I used pummeled this system with requests from an account which
is one of the wildcarded ones.  I would think there would be a
potential problem with mounting that one for the first time,
since with "--ghost" it still doesn't appear under "/home" until
the account actually tickles it.  In short, I'd expect to see
behavior like Dan's original query - "ENOENT on first reference".
But I'm not.

Our test setup is very simple:

rhel4u5server	- NFS server, has the home directories, RHEL 4 Update 5
rhel4u5client	- NFS client, test machine, gets maps and password etc.
		  entries from NIS, so user is everywhere, home directory
		  is "/home/user", et al.
othermachine	- Doesn't matter what it is, just used to run SSH to client

The user whose uid we've been using for the tests has a bunch of
machines in his $HOME/.ssh/authorized_keys file.  He's got "ssh-agent"
set up and running so that he can fire up SSH sessions to remote hosts
to run things - usually out of a local "cron" job - without needing a
password to do so, since these are automated out of "crontab".

So, basically, all our test script - which is run on "othermachine" -
does is fire up constant SSH commands inside a loop:

	ssh -l user@rhel4u5client ls -l .ssh

Since rhel4u5client is automounting /home from rhel4u5server, then
obviously in the normal case, this works just fine.

But when the bug is triggered, I see an expiry run from the
automounter on "rhel4u5client", and it umounts the user's home
directory, and returns ENOENT to the (rhel4u5client) SSH daemon
when it goes to try an open the user's "authorized_keys" file
in ".ssh".

The result being that instead of it working, the script back
on "othermachine" instead gets stopped in its tracks as it's
prompted for a passphrase.  So it's really easy to tell when
the bug has occurred.

What's odd is, once the ENOENT is returned, the SSH daemon
goes and looks for "authorized_keys2" as a backup, and that
fails - but by now, the home directory has been magically
remounted by the automounter, so a real live NFS lookup occurs
(unlike with what I just described above), NFS3ERR_NOENT gets
returned (the user doesn't have one), which is normal.

But after that, it asks for "authorized_keys" *again*, and I
have no idea why.  This NFS lookup succeeds, but by then the
SSH daemon has already taken the original ENOENT returned
while /home/user was temporarily unmounted, and thrown up the
demand for the passphrase - so the fact that "authorized_keys"
exists (again) no longer matters at that point.  And the test
script stops.

I would be happy to forward the e-mail with the strace output
and the packet traces to you and Jeff off-line, if you like.

> No-one has volunteered to try the patches I referred to in this thread
> and that's why I haven't posted them, so how about it, someone?

Due to the nature of my organization, I am not really in a
position to test patches - but surely someone else can?  (We're
a 24/7 Operations environment - getting downtimes to even do
simple reboots is like pulling teeth, involving committees.)

	- Greg
