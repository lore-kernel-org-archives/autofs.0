From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: To autofs4 or not
Date: Fri, 16 Apr 2004 06:58:17 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE718D4581@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Adam,

RHEL 3 includes the autofs4 module, but it is provided by the
"kernel-unsupported" package.  Judging by bugzilla, people have
been asking for support for the autofs4 daemon, but RH hasn't
done anything (yet?) to include it in their distribution.

For us this is a no-brainer.

If you've done enough research to find this list then you 
probably already know that you'll be getting quicker answers/
support for any issues than you would using the autofs3 that
comes with RedHat.

As for the features, there are two which autofs4 provides that
necessitated us using it rather than what's provided in the
distro:

1. multipath mounts
2. direct map support (at least enough for what we need)

The /net (and program maps in general) is nice, but it's not
a must-have for us.

As for what RedHat supports with RHEL, we try to stick with what's
supported, but there are situations where we have to add/change
things simply because it's not available in the distribution.
Autofs is just one of these cases where we're prepared to support
it internally.

-Steve

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org]On Behalf Of Alan.Burke
Sent: Thursday, April 15, 2004 6:50 PM
To: autofs@linux.kernel.org
Subject: [autofs] To autofs4 or not


Hi Everyone,

I have the task of convincing a team of admins that we should be using
autofs4 with RH8. /net is the major reason I want to use it, but some 
claim RH
does not support autofs4. Is this true? If so will they support it in 
RHE3 or
a future version?

Is there a list of autofs4 fixes or features over V3 somewhere I can used
to better make my point?


thanks,

alan

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
