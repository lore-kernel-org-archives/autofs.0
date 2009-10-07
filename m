From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP symlink with no LDAP support?
Date: Wed, 07 Oct 2009 11:53:43 +0800
Message-ID: <4ACC10C7.3000509@themaw.net>
References: <4ACAE384.6070307@beaker67.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4ACAE384.6070307@beaker67.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Chris Staub <chris@beaker67.com>
Cc: autofs@linux.kernel.org

Chris Staub wrote:
> I've just installed autofs 5.0.5, with all current patches. I do not
> have LDAP on my system, but autofs still creates a
> /lib/autofs/lookup_ldaps.so symlink, pointing to a nonexistent
> "lookup_ldap.so". When I look at modules/Makefile, I see an if statement
> saying to build lookup_ldap.so if LDAP support is requested. However,
> the command to create the lookup_ldaps.so symlink is included in the
> "install" target with all the other symlinks created by default...
> 
> ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
> 
> Am I just missing something, or should this also be enclosed in the same
> conditional used earlier in the Makefile to determine if the LDAP module
> should be built at all?

Yes, it should be conditional.
I'll fix it.

Ian
