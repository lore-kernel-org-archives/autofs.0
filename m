From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 22:08:06 +0800
Message-ID: <4A0AD446.4080004@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>	<1230012791.3043.6.camel@zeus.themaw.net>	<4A07749D.4000406@edcint.co.nz>	<4A08FEE6.7000604@themaw.net>	<4A0A533A.3060203@edcint.co.nz>	<4A0A5527.2060207@themaw.net>	<4A0A5B0A.1060701@themaw.net>
	<20090513075409.7a962fe5@tleilax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090513075409.7a962fe5@tleilax.poochiereds.net>
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
To: Jeff Layton <jlayton@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Layton wrote:
> 
> I think the only real way to solve this is to make sure that autofs
> doesn't try to escape these characters before it calls mount. I don't
> think mount does any variable interpolation, and I know mount.cifs
> doesn't so there shouldn't be any need for escape chars before '$'
> signs, assuming you're not handing these off to a shell of some sort.
> 

Yes, I'm thinking I shouldn't be double escaping the $ as using quotes
around these should prevent the $ being interpreted as a macro introducer.
