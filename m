From: Ian Kent <ikent@redhat.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
 servers
Date: Thu, 06 Jan 2011 22:07:44 +0800
Message-ID: <1294322864.2852.3.camel@perseus>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>
	<4D2581F0.8020607@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D2581F0.8020607@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Thu, 2011-01-06 at 09:48 +0100, Ondrej Valousek wrote:
> On 06.01.2011 08:09, Ian Kent wrote: 
> > > LDAP_URI="ldap://server1 ldap://server2"
> > You are supposed to be able to do this.
> > 
> Ok I have found the problem. The construction above is working well,
> indeed.
> The problem is, that you call get_dc_list() directly in the while loop
> in function find_server() where its output is not parsed (normally the
> LDAP_URI config parameter is parsed fine).
> 
> I think that to fix it we would need to:
> 1. call the get_dc_list() before the main "while" loop
> 2. fix get_dc_list() so it rather than strcatting ldap uris into a
> single string returns the pure list so that we do not have to parse it
> again. This way it can be directly processed in the main while loop.
> 
> But I do not know how would it behave if we had something like this:
> LDAP_URI="ldap:///something ldap:///something_else".
> 
> Maybe two nested loops would be better - anyway I am sure you know
> where I am pointing now :-) 

Thanks for the suggestions.
I'm still on leave so things are still going slowly for now, but I'll
get to it.

> 
> Ondrej
> 
> 
> 
> ______________________________________________________________________
> The information contained in this e-mail and in any attachments is
> confidential and is designated solely for the attention of the
> intended recipient(s). If you are not an intended recipient, you must
> not use, disclose, copy, distribute or retain this e-mail or any part
> thereof. If you have received this e-mail in error, please notify the
> sender by return e-mail and delete all copies of this e-mail from your
> computer system(s). Please direct any additional queries to:
> communications@s3group.com. Thank You. Silicon and Software Systems
> Limited. Registered in Ireland no. 378073. Registered Office: Whelan
> House, South County Business Park, Leopardstown, Dublin 18 
> 
> ______________________________________________________________________
> 
