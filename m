From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: some questions about the configuration
Date: Fri, 27 Jan 2006 10:51:47 -0500
Message-ID: <17370.16787.475552.297972@segfault.boston.redhat.com>
References: <43D4F1E0.2060201@inria.fr>
	<Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>
	<43D8F3DE.5080003@inria.fr>
	<17369.661.597510.89926@segfault.boston.redhat.com>
	<43DA3077.7090008@inria.fr>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43DA3077.7090008@inria.fr>
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
Content-Type: text/plain; charset="us-ascii"
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] some questions about the configuration; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:

Guillaume.Rousse> Jeff Moyer wrote: OK, I understand they have different
Guillaume.Rousse> nature, so they can't have the exact same naming
Guillaume.Rousse> scheme. But if auto.smb and auto.smb are exemple, they
Guillaume.Rousse> should not get installed, and especially not among
Guillaume.Rousse> configuration files whereas they are executables
Guillaume.Rousse> programs.
>>
Guillaume.Rousse> I'd rather have called ldap.master.map, smb.user.map and
Guillaume.Rousse> net.user.map, or something similar, and have them
Guillaume.Rousse> installed in the same place.
>> You can modify auto.net or auto.smb to suit your needs.  In that sense,
>> they are user-configurable automounter maps, and belong with the other
>> maps.  I understand that autofs configuration is a bit overwhelming, and
>> the documentation is lacking.  Perhaps we should focus on improving the
>> documentation.
Guillaume.Rousse> This does still look like a poor hack: if they are
Guillaume.Rousse> supposed to be adaptable to specific user needs, they
Guillaume.Rousse> should use a configuration file. And if the not flexible
Guillaume.Rousse> enough, be kept as exemples in congifuration, not
Guillaume.Rousse> installed by default (especially if not automatically
Guillaume.Rousse> used).

This is an opinion that I do not share.  /net is configured by default, and
so the auto.net map is used by default.  Additionally, supporting program
maps makes the automounter quite a bit more flexible that it would
otherwise be.

Guillaume.Rousse> And yes, documentation could get improved :)

>>>> The master map and the maps that are contained in the master map have
>>>> a different syntax.
>>>> 
>>>> 
>>>> 
>>>>> Second, it's not clear why ldap and nis use are triggered from the
>>>>> content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
>>>>> listing) use are triggered from content of
>>>>> /etc/auto.master. Shouldn't all those syntax be available from both
>>>>> locations?
>>>> 
>>>> 
>>>> Master vs client maps again.
>>
Guillaume.Rousse> According to my init script understanding, however, it
Guillaume.Rousse> seems you can't refer to LDAP user maps from
Guillaume.Rousse> /etc/auto.master, whereas you can refer to NIS user maps
Guillaume.Rousse> from there, using a syntax such as '+foobar', which is
Guillaume.Rousse> not documented in auto.master man page.
>> Your understanding is wholly incorrect.  The following web sites are
>> good references that I use frequently.  I hope they are helpful to you.
>> 
>> http://docs.sun.com/app/docs/doc/805-3479/6j3agk1v5?q=autofs&a=view
>> http://docs.sun.com/app/docs/doc/816-0211/6m6nc66nc?a=view
>> http://www.ldapguru.com/modules/newbb/viewtopic.php?topic_id=2029&forum=6
Guillaume.Rousse> Thanks for the explanation, I understand better. Let me
Guillaume.Rousse> rephrase: - it is possible to refer to additional NIS
Guillaume.Rousse> master map from /etc/auto.master, using a syntax not
Guillaume.Rousse> described in auto.master man page.  - it is not possible
Guillaume.Rousse> to do the same with ldap Is this more correct ?

Yes, this is correct.  However, note that the way it is implemented
(currently nis only) is incorrect.  Any included map should be looked for
in the locations as specified in /etc/nsswitch.conf.  This is currently not
honored.  Again, we're working to address this limitation.

Guillaume.Rousse> BTW, the default init script is quite ugly, it calls
Guillaume.Rousse> catnismap with each additional NIS master map each time a
Guillaume.Rousse> line is found beginning with '+'.

Patches are welcome.  Please use the -up options to diff.

-Jeff
