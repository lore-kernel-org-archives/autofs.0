From: Paul Jakma <paul@clubi.ie>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 02:32:03 +0100 (IST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.60.0406280220160.13910@fogarty.jakma.org>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
	<40DC6F84.5020701@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40DC6F84.5020701@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

On Fri, 25 Jun 2004, Mike Waychison wrote:

> This is just semantically racy.  If someone ssh'es into you laptop 
> and accesses the mount before you do, you can't access it.  A 
> better approach IMHO is to mount with the UID of the user on :0, 
> unmounting it on logout if possible. Thoughts?

Why should the user on :0 be special?

This is a question of policy. And there are really two questions 
here. The important one:

- Does the user have the credentials to be allowed to mount this 
device?

we already have things like pam_console and logindevperm to assist 
with answering this question, if an admin so desires.

The lesser question of, applying mainly to removable media with 
certain non-POSIX fs's:

- what credentials should the mount apply to files?

The answer to last one, given you have an answer to first question, 
is almost certainly "the credentials which triggered the mount".

no?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
Live fast, die young, and leave a flat patch of fur on the highway!
 		-- The Squirrels' Motto (The "Hell's Angels of Nature")
