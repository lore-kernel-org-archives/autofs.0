From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Wed, 26 Jul 2006 10:13:05 +0200
Message-ID: <44C72411.8070401@inria.fr>
References: <44A25311.2040501@inria.fr>	
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr>	
	<1151585997.3915.36.camel@raven.themaw.net>
	<44A4E38D.7020004@inria.fr>	
	<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>	
	<44A9216F.1030102@inria.fr>
	<1151943337.9183.44.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1151943337.9183.44.camel@raven.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

Sorry for this late reply, I was caught by work and hollidays.

Ian Kent wrote:
>>> Your example above won't work.
>>> Have you actually read the INSTALL file which tells you what options =

>>> autofs configure understands?
>> I didn't tested it, and I indeed meant --with-confdir. I just wanted to
>> express that it was quite weird to have to ressort to explicit option to
>> stick to standards.
> =

> At least it's configurable and these defaults can be changed fairly
> easily.
> =

> Perhaps I had this sort of issue in mind when I did it and clearly you
> would like to make use of it until the climate is right for it to
> change.
Personally, I'd rather take advantage of a new major version release for
this kind of changes, where people expect non-transparent changes, and
the fact than most of these directives didn't existed previously, rather
than some later 5.0 -> 5.1 transition.

>>> Fact is that for configuration to be at all usefull autofs has to =

>>> understand it and cooperate with it. The only reason I added these =

>>> configure options was in an effort to make it easier for those who wish=
 to =

>>> use different locations to customise them. If it doesn't meet with your =

>>> approval then I'm sorry but I like it and it works well for me. And I =

>>> don't see any patch submissions from you for discussion so I guess you'=
ll =

>>> just have to live with it.
>> I don't see the point of investing time to produce patches that will be
>> rejected, so I usually try to reach agreement before. Now, if all you
>> want is a patch, I can easily produce one, once we agree on the
>> following points:
>> - is is desirable to have distinct directories for automount
>> configuration and master map location (aka --with-confdir and
>> --with-mapdir switches) ?
> =

> I think so.
> Certainly the map directory is different on different distributions so
> that's definitely a good thing to have. And your point above would imply
> having the configuration directory configurable is good as well.
Distributions enforce constraints on distribution-specific items, such
as init scripts for instance. I don't think neither map or autofs daemon
configuration can get considered as "distribution specific".

But you actually answer to my question n=B03 here, aka "should they be
configurable" ? My question n=B01 was "should they be distinct" ? What
would be wrong having maps _and_ autofs configuration in the same
directory ?

>> - if they differ does, autofs_ldap_auth.conf belongs to automount
>> configuration or master map location ?
> =

> Good point.
> But I would refer back to my original reason for the division. Perhaps
> as time passes and people become familiar with the change we can move
> the program configuration file to the map directory without to much
> confusion.
> =

>> - is is really desirable to make those directories configurable, whereas
>> a fixed /etc/autofs would be perfectly fine ?
> =

> I think so for the reasons I pointed out above.
> I don't want to have to go and modify the source code if it's decided to
> change this in the future. The configure script is much easier to change
> if we need to change these defaults.
I was not discussing changing code or configure script issue, but the
use of configure script specific switches for those directories, instead
of just standard sysconfdir variable, that is already configurable.

>> - do you want initscript-related corresponding options, such as
>> --with-initscriptdir and --with-initscriptconfigdir ?
> =

> Don't think that is needed.
> I think the main issue being discussed here is the location of the
> program configuration only. Hopefully the rest is ok.
Agreed.
-- =

Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
